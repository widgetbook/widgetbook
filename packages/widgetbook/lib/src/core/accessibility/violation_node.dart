/// A single node that violated a guideline.
class ViolationNode {
  const ViolationNode({
    this.id,
    this.label,
    this.role,
    this.rect,
    required this.message,
  });

  /// The captured `SemanticsNode.id`. Unique among nodes within a single
  /// capture, so it distinguishes otherwise-identical nodes (e.g. two unlabeled
  /// buttons). It is assigned per run and recycled, so it is NOT stable across
  /// captures — do not use it to match a node between builds.
  final int? id;

  final String? label;
  final String? role;

  /// Global bounds in physical pixels as `[left, top, right, bottom]`, matching
  /// the captured screenshot. Lets a consumer highlight the node on the image.
  final List<double>? rect;

  /// A concise, human-readable description of the failure.
  final String message;

  Map<String, dynamic> toJson() => {
    if (id != null) 'id': id,
    if (label != null) 'label': label,
    if (role != null) 'role': role,
    if (rect != null) 'rect': rect,
    'message': message,
  };
}
