import '../git/diff_header.dart';
import 'use_case_metadata.dart';

class ChangedUseCase extends UseCaseMetadata {
  ChangedUseCase.fromUseCase({
    required UseCaseMetadata useCase,
    required this.modification,
  }) : super(
          name: useCase.name,
          useCaseName: useCase.useCaseName,
          componentName: useCase.componentName,
          importStatement: useCase.importStatement,
          componentImportStatement: useCase.componentImportStatement,
          componentDefinitionPath: useCase.componentDefinitionPath,
          useCaseDefinitionPath: useCase.useCaseDefinitionPath,
          designLink: useCase.designLink,
        );

  final Modification modification;

  Map<String, dynamic> toJson() {
    return {
      'modification': modification.name,
      ...super.toJson(),
    };
  }
}
