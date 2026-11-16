import 'dart:math' as math;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as p;

import 'comment.dart';

/// The widget that a [CommentAnchor] currently points to.
@internal
class ResolvedAnchor {
  const ResolvedAnchor(this.element, {required this.exact});

  final Element element;

  /// Whether [element] is the commented widget itself. If not, it is the
  /// closest widget that encloses it, e.g. after the code was changed.
  final bool exact;
}

/// Maps between widgets of a story and their [WidgetLocation]s, using the
/// creation locations that Flutter tracks in debug builds.
///
/// Only widgets created by the user's code get a location; widgets from
/// Flutter, Widgetbook, packages and generated files are skipped.
@internal
class AnchorLocator {
  AnchorLocator({
    this.root,
    this.excludedPrefix,
  });

  /// The project root, used to make locations relative.
  final String? root;

  /// The [packagePrefix] of the widgetbook package's own widgets.
  final String? excludedPrefix;

  final _locations = Expando<_CachedLocation>('locations');

  /// The runtime URI of the file that created the widget of [element],
  /// if creation locations are tracked.
  static String? creationUri(Element element) {
    return _creationLocation(element)?['file'] as String?;
  }

  /// The part of [uri] that identifies its package: everything up to its
  /// `lib` directory, or the package name of a `package:` URI.
  static String? packagePrefix(String? uri) {
    if (uri == null) return null;

    if (uri.startsWith('package:')) {
      final slash = uri.indexOf('/');
      return slash == -1 ? null : uri.substring(0, slash + 1);
    }

    final index = uri.lastIndexOf('/lib/');
    return index == -1 ? null : uri.substring(0, index + 5);
  }

  /// Whether [uri] belongs to the user's code rather than to Flutter,
  /// Widgetbook, a hosted package or a generated file.
  static bool isLocal(String uri, {String? excludedPrefix}) {
    if (excludedPrefix != null && uri.startsWith(excludedPrefix)) return false;

    const excludedSchemes = [
      'package:flutter/',
      'package:flutter_test/',
      'org-dartlang-sdk:',
    ];

    return !excludedSchemes.any(uri.startsWith) &&
        !uri.endsWith('.g.dart') &&
        !uri.contains('/.pub-cache/') &&
        !uri.contains('/packages/flutter/lib/') &&
        !uri.contains('/packages/flutter_test/lib/');
  }

  /// The path of [uri] for people and agents: relative to [root] for files
  /// on desktop, and relative to the app for `org-dartlang-app:` URIs on
  /// the web. Other URIs, e.g. `package:` URIs, are kept as they are.
  static String displayFile(String uri, String? root) {
    if (uri.startsWith('file:')) {
      final path = Uri.parse(uri).toFilePath();
      return root != null && p.isWithin(root, path)
          ? p.relative(path, from: root)
          : path;
    }

    const appScheme = 'org-dartlang-app:///';
    return uri.startsWith(appScheme) ? uri.substring(appScheme.length) : uri;
  }

  WidgetLocation? locationOf(Element element) {
    final widget = element.widget;
    final cached = _locations[widget];
    if (cached != null) return cached.location;

    final location = _localLocation(element);
    _locations[widget] = _CachedLocation(location);
    return location;
  }

  /// The closest widget of the user's code at [globalPosition] in [story].
  Element? elementAt(Element story, Offset globalPosition) {
    final storyBox = story.findRenderObject()! as RenderBox;
    final result = BoxHitTestResult();
    storyBox.hitTest(result, position: storyBox.globalToLocal(globalPosition));

    for (final entry in result.path) {
      final target = entry.target;
      final creator = target is RenderObject ? target.debugCreator : null;
      if (creator is! DebugCreator) continue;

      final element = _closestLocal(creator.element, story);
      final box = element?.findRenderObject();
      if (box is RenderBox && box.hasSize) return element;
    }

    return null;
  }

  /// Creates an anchor for the widget at [globalPosition] within [story].
  CommentAnchor capture(Element story, Offset globalPosition) {
    final storyBox = story.findRenderObject()! as RenderBox;
    final position = storyBox.globalToLocal(globalPosition);
    final point = FractionalPoint(
      position.dx / storyBox.size.width,
      position.dy / storyBox.size.height,
    );

    final element = elementAt(story, globalPosition);
    if (element == null) return CommentAnchor(point: point);

    final box = element.findRenderObject()! as RenderBox;
    final local = box.globalToLocal(globalPosition);
    final location = locationOf(element)!;

    return CommentAnchor(
      location: location,
      occurrence: _occurrences(story, location).indexOf(element),
      offset: FractionalPoint(
        local.dx / box.size.width,
        local.dy / box.size.height,
      ),
      point: point,
      chain: _chain(element, story),
      scroll: _scroll(element, story),
    );
  }

  /// Finds the widget that [anchor] points to within [story].
  ///
  /// Falls back to a widget of the same type in the same file when lines
  /// moved, and then to the closest enclosing widget of the [anchor]'s chain.
  ResolvedAnchor? resolve(Element story, CommentAnchor anchor) {
    final location = anchor.location;
    if (location == null) return null;

    final index = _index(story);

    final byScroll = anchor.scroll?.contentOffset != null;

    Element? pick(List<Element> candidates) {
      if (byScroll) return _atScrollPosition(candidates, anchor).firstOrNull;
      return candidates[anchor.occurrence.clamp(0, candidates.length - 1)];
    }

    final exact = _find(index, location);
    final exactMatch = exact == null ? null : pick(exact);
    if (exactMatch != null) return ResolvedAnchor(exactMatch, exact: true);

    final moved =
        index.entries
            .where(
              (entry) =>
                  entry.key.sameFile(location) &&
                  entry.key.widget == location.widget,
            )
            .toList()
          ..sort(
            (a, b) => (a.key.line - location.line).abs().compareTo(
              (b.key.line - location.line).abs(),
            ),
          );
    if (exact == null) {
      for (final entry in moved) {
        final match = pick(entry.value);
        if (match != null) return ResolvedAnchor(match, exact: true);
      }
    }

    for (final parent in anchor.chain) {
      final elements = _find(index, parent);
      if (elements == null) continue;

      final match = byScroll
          ? _atScrollPosition(elements, anchor).firstOrNull
          : elements.first;
      if (match != null) return ResolvedAnchor(match, exact: false);
    }

    return null;
  }

  /// Restores the scroll position recorded in [anchor], so that a lazily
  /// built widget, e.g. an item of a `ListView.builder`, gets built again.
  bool restoreScroll(Element story, CommentAnchor anchor) {
    final scrollable = scrollableOf(story, anchor);
    scrollable?.position.jumpTo(anchor.scroll!.pixels);
    return scrollable != null;
  }

  /// The scrollable that the widget of [anchor] was in when it was pinned.
  ScrollableState? scrollableOf(Element story, CommentAnchor anchor) {
    final scroll = anchor.scroll;
    if (scroll == null) return null;

    final owner = _find(_index(story), scroll.owner)?.first;
    if (owner == null) return null;

    ScrollableState? scrollable;
    void visit(Element element) {
      if (scrollable != null) return;
      if (element is StatefulElement && element.state is ScrollableState) {
        scrollable = element.state as ScrollableState;
        return;
      }
      element.visitChildren(visit);
    }

    visit(owner);
    return scrollable;
  }

  Map<WidgetLocation, List<Element>> _index(Element story) {
    final index = <WidgetLocation, List<Element>>{};

    void visit(Element element) {
      final location = locationOf(element);
      if (location != null) {
        index.putIfAbsent(location, () => []).add(element);
      }
      element.visitChildren(visit);
    }

    story.visitChildren(visit);
    return index;
  }

  List<Element>? _find(
    Map<WidgetLocation, List<Element>> index,
    WidgetLocation location,
  ) {
    return index[location] ??
        index.entries
            .where((entry) => entry.key.samePosition(location))
            .firstOrNull
            ?.value;
  }

  List<Element> _occurrences(Element story, WidgetLocation location) {
    return _index(story)[location] ?? const [];
  }

  Element? _closestLocal(Element element, Element story) {
    if (locationOf(element) != null) return element;

    Element? match;
    element.visitAncestorElements((ancestor) {
      if (ancestor == story) return false;
      if (locationOf(ancestor) != null) {
        match = ancestor;
        return false;
      }
      return true;
    });
    return match;
  }

  List<WidgetLocation> _chain(Element element, Element story) {
    final chain = <WidgetLocation>[];
    final self = locationOf(element);

    element.visitAncestorElements((ancestor) {
      if (ancestor == story || chain.length == 8) return false;

      final location = locationOf(ancestor);
      if (location != null && location != self && !chain.contains(location)) {
        chain.add(location);
      }
      return true;
    });

    return chain;
  }

  ScrollAnchor? _scroll(Element element, Element story) {
    final scrollable = element.findAncestorStateOfType<ScrollableState>();
    if (scrollable == null || !scrollable.position.hasPixels) return null;

    final scrollableElement = scrollable.context as Element;
    var withinStory = false;
    scrollableElement.visitAncestorElements((ancestor) {
      withinStory = ancestor == story;
      return !withinStory;
    });
    if (!withinStory) return null;

    final owner = _closestLocal(scrollableElement, story);
    if (owner == null) return null;

    return ScrollAnchor(
      owner: locationOf(owner)!,
      pixels: scrollable.position.pixels,
      contentOffset: _contentOffset(element),
    );
  }

  /// Where [element] starts within the content of its innermost scrollable.
  static double? _contentOffset(Element element) {
    final scrollable = element.findAncestorStateOfType<ScrollableState>();
    final box = element.findRenderObject();
    final viewport = scrollable?.context.findRenderObject();
    if (scrollable == null ||
        !scrollable.position.hasPixels ||
        box is! RenderBox ||
        viewport is! RenderBox ||
        !box.attached) {
      return null;
    }

    final origin = box.localToGlobal(Offset.zero, ancestor: viewport);
    final along = scrollable.position.axis == Axis.vertical
        ? origin.dy
        : origin.dx;
    return scrollable.position.pixels + along;
  }

  /// Keeps the [candidates] that are at the anchor's position in the scrolled
  /// content, closest first. Items of a lazily built list that is scrolled
  /// elsewhere share the source location, but not the position.
  List<Element> _atScrollPosition(
    List<Element> candidates,
    CommentAnchor anchor,
  ) {
    final expected = anchor.scroll?.contentOffset;
    if (expected == null) return candidates;

    double? distance(Element element) {
      final offset = _contentOffset(element);
      final box = element.findRenderObject();
      if (offset == null || box is! RenderBox || !box.hasSize) return null;

      final scrollable = element.findAncestorStateOfType<ScrollableState>()!;
      final extent = scrollable.position.axis == Axis.vertical
          ? box.size.height
          : box.size.width;
      final difference = (offset - expected).abs();
      return difference <= math.max(extent / 2, 8) ? difference : null;
    }

    final matches = [
      for (final candidate in candidates)
        if (distance(candidate) case final difference?) (candidate, difference),
    ]..sort((a, b) => a.$2.compareTo(b.$2));

    return [for (final (candidate, _) in matches) candidate];
  }

  WidgetLocation? _localLocation(Element element) {
    final json = _creationLocation(element);
    if (json == null) return null;

    final uri = json['file'] as String;
    if (!isLocal(uri, excludedPrefix: excludedPrefix)) return null;

    return WidgetLocation(
      widget: element.widget.runtimeType.toString().split('<').first,
      uri: uri,
      file: displayFile(uri, root),
      line: json['line'] as int,
      column: json['column'] as int,
    );
  }

  static Map<String, Object?>? _creationLocation(Element element) {
    final json = element.toDiagnosticsNode().toJsonMap(
      InspectorSerializationDelegate(
        service: WidgetInspectorService.instance,
        subtreeDepth: 0,
      ),
    );
    return (json['creationLocation'] as Map?)?.cast<String, Object?>();
  }
}

class _CachedLocation {
  const _CachedLocation(this.location);

  final WidgetLocation? location;
}
