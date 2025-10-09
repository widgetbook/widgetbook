class StoryMetadata {
  const StoryMetadata({
    required this.name,
    required this.designLink,
  });

  final String name;
  final String? designLink;

  // ignore: sort_constructors_first
  factory StoryMetadata.fromJson(Map<String, dynamic> json) {
    return StoryMetadata(
      name: json['name'] as String,
      designLink: json['designLink'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'designLink': designLink,
    };
  }
}
