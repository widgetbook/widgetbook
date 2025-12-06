typedef Name = String;
typedef FieldValues = Map<Name, String>;

class ScenarioMetadata {
  ScenarioMetadata({
    required this.name,
    required this.path,
    required this.modes,
    required this.args,
  });

  final String name;
  final String path;
  final Map<Name, FieldValues?> modes;
  final Map<Name, FieldValues?> args;

  // ignore: sort_constructors_first
  factory ScenarioMetadata.fromJson(Map<String, dynamic> json) {
    Map<Name, FieldValues?> parseQueryGroups(Map<Name, dynamic> queryGroups) {
      return queryGroups.map(
        (name, values) => MapEntry(
          name,
          // can be null in case of nullable arg
          values == null
              ? null
              : (values as Map<Name, dynamic>).map(
                  (key, value) => MapEntry(key, value as String),
                ),
        ),
      );
    }

    final modes = json['modes'] as Map<Name, dynamic>;
    final args = json['args'] as Map<Name, dynamic>;
    return ScenarioMetadata(
      name: json['name'] as String,
      path: json['path'] as String,
      modes: parseQueryGroups(modes),
      args: parseQueryGroups(args),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'path': path,
      'modes': modes,
      'args': args,
    };
  }
}
