import 'violation_node.dart';

/// A guideline failure, optionally pinned to one or more [nodes].
class GuidelineViolation {
  const GuidelineViolation({
    required this.guidelineId,
    required this.title,
    this.helpUrl,
    this.nodes = const [],
    this.reason,
  });

  final String guidelineId;
  final String title;
  final String? helpUrl;

  /// The offending nodes. Empty for adapted Flutter guidelines, which only
  /// report a coarse [reason].
  final List<ViolationNode> nodes;

  /// Raw text from an adapted guideline — for "details" only, not primary UI.
  final String? reason;

  Map<String, dynamic> toJson() => {
    'id': guidelineId,
    'title': title,
    if (helpUrl != null) 'helpUrl': helpUrl,
    if (nodes.isNotEmpty) 'nodes': nodes.map((node) => node.toJson()).toList(),
    if (reason != null) 'reason': reason,
  };
}
