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
    this.excludedDirectory,
  });

  /// The project root, used to make locations relative.
  final String? root;

  /// The `lib` directory of the widgetbook package.
  final String? excludedDirectory;

  final _locations = Expando<_CachedLocation>('locations');

  /// The file that created the widget of [element], if creation locations
  /// are tracked.
  static String? creationFile(Element element) {
    return _creationLocation(element)?['file'] as String?;
  }

  /// The `lib` directory that contains [file].
  static String? libraryDirectory(String? file) {
    if (file == null) return null;

    final path = _toPath(file);
    final index = path.lastIndexOf('${p.separator}lib${p.separator}');
    return index == -1 ? null : path.substring(0, index + 4);
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

    final exact = index[location];
    if (exact != null) {
      final occurrence = anchor.occurrence.clamp(0, exact.length - 1);
      return ResolvedAnchor(exact[occurrence], exact: true);
    }

    final moved =
        index.entries
            .where(
              (entry) =>
                  entry.key.file == location.file &&
                  entry.key.widget == location.widget,
            )
            .toList()
          ..sort(
            (a, b) => (a.key.line - location.line).abs().compareTo(
              (b.key.line - location.line).abs(),
            ),
          );
    if (moved.isNotEmpty) {
      final elements = moved.first.value;
      final occurrence = anchor.occurrence.clamp(0, elements.length - 1);
      return ResolvedAnchor(elements[occurrence], exact: true);
    }

    for (final parent in anchor.chain) {
      final elements = index[parent];
      if (elements != null) {
        return ResolvedAnchor(elements.first, exact: false);
      }
    }

    return null;
  }

  /// Restores the scroll position recorded in [anchor], so that a lazily
  /// built widget, e.g. an item of a `ListView.builder`, gets built again.
  bool restoreScroll(Element story, CommentAnchor anchor) {
    final scroll = anchor.scroll;
    if (scroll == null) return false;

    final owner = _index(story)[scroll.owner]?.first;
    if (owner == null) return false;

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
    scrollable?.position.jumpTo(scroll.pixels);
    return scrollable != null;
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
    );
  }

  WidgetLocation? _localLocation(Element element) {
    final json = _creationLocation(element);
    if (json == null) return null;

    final path = _toPath(json['file'] as String);
    if (!_isLocal(path)) return null;

    return WidgetLocation(
      widget: element.widget.runtimeType.toString().split('<').first,
      file: root != null && p.isWithin(root!, path)
          ? p.relative(path, from: root)
          : path,
      line: json['line'] as int,
      column: json['column'] as int,
    );
  }

  bool _isLocal(String path) {
    if (excludedDirectory != null && p.isWithin(excludedDirectory!, path)) {
      return false;
    }

    return !path.endsWith('.g.dart') &&
        !path.contains('${p.separator}.pub-cache${p.separator}') &&
        !path.contains(
          p.join('packages', 'flutter', 'lib') + p.separator,
        ) &&
        !path.contains(
          p.join('packages', 'flutter_test', 'lib') + p.separator,
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

  static String _toPath(String file) {
    return file.startsWith('file:') ? Uri.parse(file).toFilePath() : file;
  }
}

class _CachedLocation {
  const _CachedLocation(this.location);

  final WidgetLocation? location;
}
