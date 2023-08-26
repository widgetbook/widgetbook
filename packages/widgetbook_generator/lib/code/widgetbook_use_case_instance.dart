import 'package:code_builder/code_builder.dart';

import '../models/use_case_metadata.dart';
import 'refer.dart';
import 'widgetbook_instance.dart';

/// [InvokeExpression] for [WidgetbookUseCase]
class WidgetbookUseCaseInstance extends WidgetbookInstance {
  WidgetbookUseCaseInstance({
    required UseCaseMetadata useCase,
    required super.baseDir,
  }) : super(
          type: 'WidgetbookUseCase',
          args: {
            'name': literalString(useCase.name),
            'builder': referRelative(
              useCase.functionName,
              useCase.importUri,
              baseDir,
            ),
          },
        );
}
