import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:widgetbook_generator/models/widgetbook_data.dart';

part 'widgetbook_use_case_data.freezed.dart';
part 'widgetbook_use_case_data.g.dart';

@freezed
class WidgetbookUseCaseData extends WidgetbookData
    with _$WidgetbookUseCaseData {
  factory WidgetbookUseCaseData({
    // Name of the builder function defining the use-case
    required String name,
    // Name of the use-case, e.g. 'Default'
    required String useCaseName,
    // Name of the use-case, e.g. 'ElevatedButton'
    // This will be extracted from the type
    required String componentName,
    // Import statement of the use-case definition
    required String importStatement,
    // Import statement of the component
    required String componentImportStatement,
    required List<String> dependencies,
    // The path to the file containing the component
    required String componentDefinitionPath,
    // The path to the file containing the use-case definition
    required String useCaseDefinitionPath,
    // The link to a design file or design component
    required String? designLink,
  }) = _WidgetbookUseCaseData;

  factory WidgetbookUseCaseData.fromJson(Map<String, dynamic> json) =>
      _$WidgetbookUseCaseDataFromJson(json);
}
