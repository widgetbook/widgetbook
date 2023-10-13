import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import 'element_metadata.dart';

/// Contains metadata about elements annotated with [UseCase].
class UseCaseMetadata extends ElementMetadata {
  const UseCaseMetadata({
    required this.functionName,
    required this.designLink,
    required super.name,
    required super.importUri,
    required super.filePath,
    required this.component,
    required this.pathInWidgetbook,
  });

  /// The name of the [UseCase]-annotated function.
  final String functionName;

  /// URL to Figma's design file as defined in [UseCase.designLink].
  final String? designLink;

  /// Metadata about the component that contains the [UseCase].
  final ElementMetadata component;

  /// The path this element is placed under in the rendered widgetbook.
  final String pathInWidgetbook;

  // ignore: sort_constructors_first
  factory UseCaseMetadata.fromJson(Map<String, dynamic> json) {
    return UseCaseMetadata(
      functionName: json['name'] as String,
      designLink: json['designLink'] as String?,
      name: json['useCaseName'] as String,
      importUri: json['importStatement'] as String,
      filePath: json['useCaseDefinitionPath'] as String,
      pathInWidgetbook: json['pathInWidgetbook'] as String,
      component: ElementMetadata(
        name: json['componentName'] as String,
        importUri: json['componentImportStatement'] as String,
        filePath: json['componentDefinitionPath'] as String,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    // Currently the JSON representation does NOT match the class structure
    // because the keys are read by `widgetbook_cli` and sent to the server.
    // Changing the keys would be a breaking change if user does not update
    // the CLI to the latest version.
    return {
      'name': functionName,
      'designLink': designLink,
      'useCaseName': name,
      'importStatement': importUri,
      'useCaseDefinitionPath': filePath,
      'componentName': component.name,
      'componentImportStatement': component.importUri,
      'componentDefinitionPath': component.filePath,
      'pathInWidgetbook': pathInWidgetbook,
    };
  }
}
