import '../helpers/package_helper.dart';

class Package {
  const Package({
    required this.name,
    required this.path,
    required this.type,
  });

  /// The project name
  final String name;

  /// Path of the project
  final String path;

  /// Type of the project (Dart Package or a Flutter Project)
  final PackageType type;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'path': path,
      'type': type.name,
    };
  }

  // ignore: sort_constructors_first
  factory Package.fromJson(Map<String, dynamic> map) {
    return Package(
      name: map['name'] as String,
      path: map['path'] as String,
      type: PackageType.values.byName(map['type'] as String),
    );
  }
}
