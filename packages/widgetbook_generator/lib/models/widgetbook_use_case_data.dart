import 'widgetbook_data.dart';

class WidgetbookUseCaseData extends WidgetbookData {
  WidgetbookUseCaseData({
    required super.name,
    required super.importStatement,
    required super.dependencies,
    required this.useCaseName,
    required this.componentName,
    required this.componentImportStatement,
    required this.componentDefinitionPath,
    required this.useCaseDefinitionPath,
    required this.designLink,
  });

  factory WidgetbookUseCaseData.fromJson(Map<String, dynamic> json) {
    return WidgetbookUseCaseData(
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

  @override
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
