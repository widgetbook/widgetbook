import 'dart:math' as math;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as p;

import 'comment.dart';

/// The widget that a [CommentAnchor] currently points to.
@internal
class ResolvedAnchor {
  const ResolvedAnchor(
    this.element, {
    required this.exact,
    this.uncertain = false,
  });

  final Element element;

  /// Whether [element] is the commented widget itself. If not, it is the
  /// closest widget that encloses it, e.g. after the code was changed.
  final bool exact;

  /// Whether [element] is only the best guess: several widgets could be the
  /// commented one, and none of them shows what it showed when pinned.
  final bool uncertain;
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
      signature: signatureOf(element),
    );
  }

  /// The text that [element] shows, including icons, which are rendered as
  /// text. Limited to a short prefix, as it only tells widgets apart.
  static String? signatureOf(Element element) {
    final parts = <String>[];
    var length = 0;

    void visit(Element child) {
      if (length >= _signatureLength) return;
      final widget = child.widget;
      if (widget is RichText) {
        final text = widget.text.toPlainText().trim();
        if (text.isNotEmpty) {
          parts.add(text);
          length += text.length;
        }
      }
      child.visitChildren(visit);
    }

    visit(element);
    if (parts.isEmpty) return null;

    final signature = parts.join(' ');
    return signature.length > _signatureLength
        ? signature.substring(0, _signatureLength)
        : signature;
  }

  static const _signatureLength = 120;

  /// Finds the widget that [anchor] points to within [story].
  ///
  /// Falls back to a widget of the same type in the same file when lines
  /// moved, and then to the closest enclosing widget of the [anchor]'s chain.
  ResolvedAnchor? resolve(Element story, CommentAnchor anchor) {
    final location = anchor.location;
    if (location == null) return null;

    final index = _index(story);

    final byScroll = anchor.scroll?.contentOffset != null;

    List<Element> ordered(List<Element> elements) {
      final occurrence = anchor.occurrence;
      final indexed = [...elements.indexed]
        ..sort(
          (a, b) =>
              (a.$1 - occurrence).abs().compareTo((b.$1 - occurrence).abs()),
        );
      return [for (final (_, element) in indexed) element];
    }

    final sameType =
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

    final exact = _find(index, location) ?? const <Element>[];
    final candidates = {
      ...ordered(exact),
      for (final entry in sameType) ...ordered(entry.value),
    }.toList();
    final signature = anchor.signature;

    Element? showingSignature(List<Element> elements) {
      if (signature == null) return null;
      for (final element in elements) {
        if (signatureOf(element) == signature) return element;
      }
      return null;
    }

    if (byScroll) {
      final moved = showingSignature(_byScrollDistance(candidates, anchor));
      if (moved != null) return ResolvedAnchor(moved, exact: true);

      final atPosition = _atScrollPosition(candidates, anchor).firstOrNull;
      if (atPosition != null) {
        return ResolvedAnchor(
          atPosition,
          exact: true,
          uncertain: signature != null && candidates.length > 1,
        );
      }
    } else if (candidates.isNotEmpty) {
      if (signature == null || candidates.length == 1) {
        return ResolvedAnchor(candidates.first, exact: true);
      }

      final match = showingSignature(candidates);
      return match != null
          ? ResolvedAnchor(match, exact: true)
          : ResolvedAnchor(candidates.first, exact: true, uncertain: true);
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

  /// Runs [run] with one index of [story] for all lookups, instead of
  /// walking the widget tree for each of them.
  T batch<T>(Element story, T Function() run) {
    _batchIndex = (story, _buildIndex(story));
    try {
      return run();
    } finally {
      _batchIndex = null;
    }
  }

  (Element, Map<WidgetLocation, List<Element>>)? _batchIndex;

  Map<WidgetLocation, List<Element>> _index(Element story) {
    if (_batchIndex
        case (
          final batchStory,
          final index,
        )
        when batchStory == story) {
      return index;
    }
    return _buildIndex(story);
  }

  Map<WidgetLocation, List<Element>> _buildIndex(Element story) {
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

  /// Orders [candidates] by their distance to the anchor's position in the
  /// scrolled content, without dropping distant ones.
  List<Element> _byScrollDistance(
    List<Element> candidates,
    CommentAnchor anchor,
  ) {
    final expected = anchor.scroll!.contentOffset!;
    final distances = [
      for (final candidate in candidates)
        (
          candidate,
          (_contentOffset(candidate) ?? double.infinity) - expected,
        ),
    ]..sort((a, b) => a.$2.abs().compareTo(b.$2.abs()));

    return [for (final (candidate, _) in distances) candidate];
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
