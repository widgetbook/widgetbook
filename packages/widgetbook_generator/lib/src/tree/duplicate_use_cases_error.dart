import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import '../models/use_case_metadata.dart';
import 'tree_node.dart';

class DuplicateUseCasesError extends Error {
  DuplicateUseCasesError(
    this.componentNode,
    this.useCase,
  );

  final TreeNode<String> componentNode;
  final UseCaseMetadata useCase;

  @override
  String toString() {
    final existingNode = componentNode.children[useCase.name]!;
    final existingUseCase = existingNode.data as UseCaseMetadata;

    return '''
      Duplicate use-case name "${useCase.name}" for `${componentNode.data}`.
      Change the `@${UseCase}.name` for one of the following:
        1. ${existingUseCase.importUri} -> ${existingUseCase.functionName}
        2. ${useCase.importUri} -> ${useCase.functionName}
      ''';
  }
}
