/// The lifecycle of a [Comment].
///
/// Only the user creates, submits, resolves and reopens comments;
/// the agent can only move them to [inProgress] and [done].
enum CommentStatus {
  /// Placed in the Widgetbook UI but not submitted yet.
  draft,

  /// Submitted by the user and waiting for the agent.
  open,

  /// Picked up by the agent.
  inProgress,

  /// Addressed by the agent and waiting for the user to verify it.
  done,

  /// Verified and closed by the user.
  resolved;

  static CommentStatus parse(String value) {
    return CommentStatus.values.firstWhere(
      (status) => status.name == value,
      orElse: () => throw FormatException('Unknown comment status "$value"'),
    );
  }
}

enum CommentAuthor { user, agent }

class CommentMessage {
  const CommentMessage({
    required this.author,
    required this.text,
    required this.createdAt,
  });

  factory CommentMessage.fromJson(Map<String, dynamic> json) {
    return CommentMessage(
      author: CommentAuthor.values.byName(json['author'] as String),
      text: json['text'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  final CommentAuthor author;
  final String text;
  final DateTime createdAt;

  Map<String, dynamic> toJson() => {
    'author': author.name,
    'text': text,
    'createdAt': createdAt.toUtc().toIso8601String(),
  };
}

/// A comment thread pinned to a widget of a story.
class Comment {
  Comment({
    required this.id,
    required this.storyPath,
    required this.storyUrl,
    required this.status,
    required this.anchor,
    required this.messages,
    required this.createdAt,
    required this.updatedAt,
    this.screenshot,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'] as String,
      storyPath: json['storyPath'] as String,
      storyUrl: json['storyUrl'] as String?,
      status: CommentStatus.parse(json['status'] as String),
      anchor: (json['anchor'] as Map?)?.cast<String, dynamic>() ?? const {},
      messages: (json['messages'] as List)
          .cast<Map<String, dynamic>>()
          .map(CommentMessage.fromJson)
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      screenshot: json['screenshot'] as String?,
    );
  }

  final String id;

  /// The navigation path of the story, e.g. `widgets/PhraseCard/Default`.
  final String storyPath;

  /// The Widgetbook URL (path and query) that restores the exact state
  /// of the story, including its args and addons, when the comment was placed.
  final String? storyUrl;

  CommentStatus status;

  /// Where the comment is pinned. The Widgetbook UI owns its shape; it
  /// contains the source location of the pinned widget, its local creation
  /// chain and the relative position of the pin.
  final Map<String, dynamic> anchor;

  final List<CommentMessage> messages;
  final DateTime createdAt;
  DateTime updatedAt;

  /// The file name of the screenshot next to the comment's JSON file.
  final String? screenshot;

  Map<String, dynamic> toJson() => {
    'id': id,
    'storyPath': storyPath,
    'storyUrl': storyUrl,
    'status': status.name,
    'anchor': anchor,
    'messages': messages.map((message) => message.toJson()).toList(),
    'createdAt': createdAt.toUtc().toIso8601String(),
    'updatedAt': updatedAt.toUtc().toIso8601String(),
    if (screenshot != null) 'screenshot': screenshot,
  };
}
