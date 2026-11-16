import 'package:meta/meta.dart';

/// Mirrors the comment lifecycle of the `widgetbook mcp` server.
@internal
enum CommentStatus {
  draft,
  open,
  inProgress,
  done,
  resolved;

  static CommentStatus parse(String value) {
    return CommentStatus.values.firstWhere(
      (status) => status.name == value,
      orElse: () => CommentStatus.open,
    );
  }
}

@internal
class CommentMessage {
  const CommentMessage({
    required this.fromAgent,
    required this.text,
  });

  factory CommentMessage.fromJson(Map<String, dynamic> json) {
    return CommentMessage(
      fromAgent: json['author'] == 'agent',
      text: json['text'] as String,
    );
  }

  final bool fromAgent;
  final String text;
}

@internal
class StoryComment {
  const StoryComment({
    required this.id,
    required this.status,
    required this.anchor,
    required this.messages,
  });

  factory StoryComment.fromJson(Map<String, dynamic> json) {
    return StoryComment(
      id: json['id'] as String,
      status: CommentStatus.parse(json['status'] as String),
      anchor: CommentAnchor.fromJson(
        (json['anchor'] as Map?)?.cast<String, dynamic>() ?? const {},
      ),
      messages: (json['messages'] as List)
          .cast<Map<String, dynamic>>()
          .map(CommentMessage.fromJson)
          .toList(),
    );
  }

  final String id;
  final CommentStatus status;
  final CommentAnchor anchor;
  final List<CommentMessage> messages;
}

/// A source location of a widget, as recorded by Flutter's widget
/// creation tracking in debug builds.
@internal
class WidgetLocation {
  const WidgetLocation({
    required this.widget,
    required this.file,
    required this.line,
    required this.column,
  });

  static WidgetLocation? fromJson(Object? json) {
    if (json is! Map) return null;

    return WidgetLocation(
      widget: json['widget'] as String,
      file: json['file'] as String,
      line: json['line'] as int,
      column: json['column'] as int,
    );
  }

  final String widget;
  final String file;
  final int line;
  final int column;

  String get key => '$file:$line:$column';

  Map<String, dynamic> toJson() => {
    'widget': widget,
    'file': file,
    'line': line,
    'column': column,
  };

  @override
  bool operator ==(Object other) => other is WidgetLocation && other.key == key;

  @override
  int get hashCode => key.hashCode;
}

/// Where a comment is pinned.
///
/// The pin is attached to the widget at [location], so it follows the widget
/// when the story scrolls, zooms or changes its viewport. [point] is the
/// fallback when no widget can be found, e.g. in release builds.
@internal
class CommentAnchor {
  const CommentAnchor({
    required this.point,
    this.location,
    this.occurrence = 0,
    this.offset,
    this.chain = const [],
    this.scroll,
  });

  factory CommentAnchor.fromJson(Map<String, dynamic> json) {
    final location = (json['location'] as Map?)?.cast<String, dynamic>();
    final offset = json['offset'] as Map?;
    final point = json['point'] as Map?;
    final scroll = json['scroll'] as Map?;

    return CommentAnchor(
      location: WidgetLocation.fromJson(location),
      occurrence: location?['occurrence'] as int? ?? 0,
      offset: offset == null ? null : _fraction(offset),
      point: point == null ? const FractionalPoint(0, 0) : _fraction(point),
      chain: (json['chain'] as List? ?? const [])
          .map(WidgetLocation.fromJson)
          .whereType<WidgetLocation>()
          .toList(),
      scroll: scroll == null
          ? null
          : ScrollAnchor(
              owner: WidgetLocation.fromJson(scroll['owner'])!,
              pixels: (scroll['pixels'] as num).toDouble(),
            ),
    );
  }

  /// The widget the comment is pinned to.
  final WidgetLocation? location;

  /// Which of the widgets created at [location] is meant, in tree order,
  /// e.g. the third item of a list.
  final int occurrence;

  /// The position of the pin within the widget's bounds.
  final FractionalPoint? offset;

  /// The position of the pin within the story's bounds.
  final FractionalPoint point;

  /// The widgets from the user's code that enclose [location],
  /// from the innermost to the outermost.
  final List<WidgetLocation> chain;

  /// The scroll position of the innermost scrollable around the widget.
  final ScrollAnchor? scroll;

  Map<String, dynamic> toJson() => {
    if (location != null)
      'location': {...location!.toJson(), 'occurrence': occurrence},
    if (offset != null) 'offset': offset!.toJson(),
    'point': point.toJson(),
    'chain': chain.map((location) => location.toJson()).toList(),
    if (scroll != null)
      'scroll': {'owner': scroll!.owner.toJson(), 'pixels': scroll!.pixels},
  };

  static FractionalPoint _fraction(Map<dynamic, dynamic> json) {
    return FractionalPoint(
      (json['x'] as num).toDouble(),
      (json['y'] as num).toDouble(),
    );
  }
}

@internal
class ScrollAnchor {
  const ScrollAnchor({required this.owner, required this.pixels});

  /// The widget from the user's code that creates the scrollable.
  final WidgetLocation owner;
  final double pixels;
}

/// A point relative to a size, where (0, 0) is the top left
/// and (1, 1) the bottom right corner.
@internal
class FractionalPoint {
  const FractionalPoint(this.x, this.y);

  final double x;
  final double y;

  Map<String, dynamic> toJson() => {'x': _round(x), 'y': _round(y)};

  static double _round(double value) => (value * 10000).round() / 10000;
}
