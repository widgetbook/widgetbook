class WorkspaceResponse {
  const WorkspaceResponse({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  // ignore: sort_constructors_first
  factory WorkspaceResponse.fromJson(Map<String, dynamic> json) {
    return WorkspaceResponse(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }
}
