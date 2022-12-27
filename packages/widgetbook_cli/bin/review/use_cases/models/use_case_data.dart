import 'package:freezed_annotation/freezed_annotation.dart';

part 'use_case_data.freezed.dart';
part 'use_case_data.g.dart';

@freezed
class UseCaseData with _$UseCaseData {
  factory UseCaseData({
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
    // A link to a component or variant
    String? designLink,
  }) = _UseCaseData;

  factory UseCaseData.fromJson(Map<String, dynamic> json) =>
      _$UseCaseDataFromJson(json);
}
