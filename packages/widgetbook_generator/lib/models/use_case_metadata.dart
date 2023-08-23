import 'package:widgetbook_annotation/widgetbook_annotation.dart';

/// Contains metadata about elements annotated with [UseCase].
class UseCaseMetadata {
  UseCaseMetadata({
    required this.name,
    required this.importStatement,
    required this.dependencies,
    required this.useCaseName,
    required this.componentName,
    required this.componentImportStatement,
    required this.componentDefinitionPath,
    required this.useCaseDefinitionPath,
    required this.designLink,
  });

  factory UseCaseMetadata.fromJson(Map<String, dynamic> json) {
    return UseCaseMetadata(
      name: json['name'] as String,
      importStatement: json['importStatement'] as String,
      dependencies: (json['dependencies'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      useCaseName: json['useCaseName'] as String,
      componentName: json['componentName'] as String,
      componentImportStatement: json['componentImportStatement'] as String,
      componentDefinitionPath: json['componentDefinitionPath'] as String,
      useCaseDefinitionPath: json['useCaseDefinitionPath'] as String,
      designLink: json['designLink'] as String?,
    );
  }

  /// The name of the annotated element
  final String name;

  /// The import statement necessary to reference this type or function in the
  /// final output file
  final String importStatement;

  /// The import statements defined by the file in which the annotation is used.
  final List<String> dependencies;

  /// Name of the use-case, e.g. 'Default'
  final String useCaseName;

  /// Name of the use-case, e.g. 'ElevatedButton'
  /// This will be extracted from the type
  final String componentName;

  /// Import statement of the component
  final String componentImportStatement;

  // The path to the file containing the component
  final String componentDefinitionPath;

  /// The path to the file containing the use-case definition
  final String useCaseDefinitionPath;

  /// The link to a design file or design component
  final String? designLink;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'importStatement': importStatement,
      'dependencies': dependencies,
      'useCaseName': useCaseName,
      'componentName': componentName,
      'componentImportStatement': componentImportStatement,
      'componentDefinitionPath': componentDefinitionPath,
      'useCaseDefinitionPath': useCaseDefinitionPath,
      'designLink': designLink,
    };
  }
}
