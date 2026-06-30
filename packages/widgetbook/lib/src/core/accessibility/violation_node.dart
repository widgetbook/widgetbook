/// A single node that violated a guideline.
class ViolationNode {
  const ViolationNode({
    this.label,
    this.role,
    this.rect,
    required this.message,
  });

  final String? label;
  final String? role;

  /// Global bounds in physical pixels as `[left, top, right, bottom]`, matching
  /// the captured screenshot. Lets a consumer highlight the node on the image.
  final List<double>? rect;

  /// A concise, human-readable description of the failure.
  final String message;

  Map<String, dynamic> toJson() => {
    if (label != null) 'label': label,
    if (role != null) 'role': role,
    if (rect != null) 'rect': rect,
    'message': message,
  };
}
