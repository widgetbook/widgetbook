import '../git/modification.dart';

class ChangedUseCase {
  const ChangedUseCase({
    required this.name,
    required this.componentName,
    required this.componentDefinitionPath,
    required this.modification,
    required this.designLink,
  });

  final String name;
  final String componentName;
  final String componentDefinitionPath;
  final Modification modification;
  final String? designLink;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'componentName': componentName,
      'componentDefinitionPath': componentDefinitionPath,
      'modification': modification.name,
      'designLink': designLink,
    };
  }

  // ignore: sort_constructors_first
  factory ChangedUseCase.fromJson(Map<String, dynamic> map) {
    return ChangedUseCase(
      name: map['name'] as String,
      componentName: map['componentName'] as String,
      componentDefinitionPath: map['componentDefinitionPath'] as String,
      modification: Modification.values.byName(map['modification'] as String),
      designLink:
          map['designLink'] != null ? map['designLink'] as String : null,
    );
  }
}
