class ArgMetadata {
  ArgMetadata({
    required this.name,
    required this.value,
  });

  final String name;
  final String value;

  static ArgMetadata fromJson(Map<String, dynamic> json) {
    return ArgMetadata(
      name: json['name'] as String,
      value: json['value'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'value': value,
    };
  }
}

class ModeMetadata {
  ModeMetadata({
    required this.value,
  });

  final String value;

  static ModeMetadata fromJson(Map<String, dynamic> json) {
    return ModeMetadata(
      value: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'value': value,
    };
  }
}

class ScenarioMetadata {
  ScenarioMetadata({
    required this.name,
    required this.modes,
    required this.args,
  });
  final String name;
  final List<ModeMetadata> modes;
  final List<ArgMetadata> args;

  static ScenarioMetadata fromJson(Map<String, dynamic> json) {
    return ScenarioMetadata(
      name: json['name'] as String,
      modes: [],
      args: [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'modes': modes.map((mode) => mode.toJson()).toList(),
      'args': args.map((arg) => arg.toJson()).toList(),
    };
  }
}
