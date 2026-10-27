class ProjectResponse {
  const ProjectResponse({
    required this.id,
    required this.name,
    required this.createdAt,
  });

  final String id;
  final String name;
  final DateTime createdAt;

  // ignore: sort_constructors_first
  factory ProjectResponse.fromJson(Map<String, dynamic> json) {
    return ProjectResponse(
      id: json['id'] as String,
      name: json['name'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}
