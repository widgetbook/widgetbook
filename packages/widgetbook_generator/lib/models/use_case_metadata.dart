import 'package:widgetbook_annotation/widgetbook_annotation.dart';

/// Contains metadata about elements annotated with [UseCase].
class UseCaseMetadata {
  UseCaseMetadata({
    required this.name,
    required this.useCaseName,
    required this.importStatement,
    required this.useCaseDefinitionPath,
    required this.componentName,
    required this.componentImportStatement,
    required this.componentDefinitionPath,
    required this.designLink,
  });

  factory UseCaseMetadata.fromJson(Map<String, dynamic> json) {
    return UseCaseMetadata(
      name: json['name'] as String,
      useCaseName: json['useCaseName'] as String,
      importStatement: json['importStatement'] as String,
      useCaseDefinitionPath: json['useCaseDefinitionPath'] as String,
      componentName: json['componentName'] as String,
      componentImportStatement: json['componentImportStatement'] as String,
      componentDefinitionPath: json['componentDefinitionPath'] as String,
      designLink: json['designLink'] as String?,
    );
  }

  /// The name of the [UseCase]-annotated function.
  final String name;

  /// Name of the use-case, as defined in [UseCase.name].
  final String useCaseName;

  /// Import statement used to reference the [UseCase]-annotated function.
  final String importStatement;

  /// Path to the [UseCase]-annotated function's file.
  final String useCaseDefinitionPath;

  /// Name of the component, as defined in [UseCase.type]
  final String componentName;

  /// Import statement used to reference [UseCase.type].
  final String componentImportStatement;

  /// Path to the component's file.
  final String componentDefinitionPath;

  /// URL to Figma's design file as defined in [UseCase.designLink].
  final String? designLink;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'useCaseName': useCaseName,
      'importStatement': importStatement,
      'useCaseDefinitionPath': useCaseDefinitionPath,
      'componentName': componentName,
      'componentImportStatement': componentImportStatement,
      'componentDefinitionPath': componentDefinitionPath,
      'designLink': designLink,
    };
  }
}
