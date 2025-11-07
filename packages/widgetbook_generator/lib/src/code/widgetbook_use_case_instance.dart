import 'package:code_builder/code_builder.dart';

import '../models/use_case_metadata.dart';
import 'widgetbook_instance.dart';

/// [InvokeExpression] for `WidgetbookUseCase`
class WidgetbookUseCaseInstance extends WidgetbookInstance {
  WidgetbookUseCaseInstance({
    required UseCaseMetadata useCase,
  }) : super(
         type: 'WidgetbookUseCase',
         args: {
           'name': literalString(useCase.name),
           'builder': refer(
             useCase.functionName,
             useCase.importUri,
           ),
           if (useCase.designLink != null)
             'designLink': literalString(useCase.designLink!),
         },
       );
}
