import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import 'element_metadata.dart';

/// Contains metadata about elements annotated with [UseCase].
class UseCaseMetadata extends ElementMetadata {
  UseCaseMetadata({
    required this.functionName,
    required this.designLink,
    required super.name,
    required super.importUri,
    required super.filePath,
    required this.component,
  });

  /// The name of the [UseCase]-annotated function.
  final String functionName;

  /// URL to Figma's design file as defined in [UseCase.designLink].
  final String? designLink;

  /// Metadata about the component that contains the [UseCase].
  final ElementMetadata component;

  // ignore: sort_constructors_first
  factory UseCaseMetadata.fromJson(Map<String, dynamic> json) {
    return UseCaseMetadata(
      functionName: json['name'] as String,
      designLink: json['designLink'] as String?,
      name: json['useCaseName'] as String,
      importUri: json['importStatement'] as String,
      filePath: json['useCaseDefinitionPath'] as String,
      component: ElementMetadata(
        name: json['componentName'] as String,
        importUri: json['componentImportStatement'] as String,
        filePath: json['componentDefinitionPath'] as String,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': functionName,
      'designLink': designLink,
      'useCaseName': name,
      'importStatement': importUri,
      'useCaseDefinitionPath': filePath,
      'componentName': component.name,
      'componentImportStatement': component.importUri,
      'componentDefinitionPath': component.filePath,
    };
  }
}
