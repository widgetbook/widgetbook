class ComponentMetadata {
  const ComponentMetadata({
    required this.name,
    required this.path,
  });

  final String name;
  final String path;

  static ComponentMetadata fromJson(Map<String, dynamic> json) {
    return ComponentMetadata(
      name: json['name'] as String,
      path: json['path'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'path': path,
    };
  }
}
