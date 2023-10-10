import '../git/diff_header.dart';

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
}
