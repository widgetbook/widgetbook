import 'package:widgetbook_generator/code_generators/instances/instance.dart';
import 'package:widgetbook_generator/code_generators/instances/lambda_instance.dart';
import 'package:widgetbook_generator/code_generators/properties/property.dart';

/// An instance for WidetbookUseCase
class WidgetbookUseCaseInstance extends Instance {
  /// Creates a new instance of [WidgetbookUseCaseInstance]
  WidgetbookUseCaseInstance({
    required String useCaseName,
    required String functionName,
  }) : super(
          name: 'WidgetbookUseCase',
          properties: [
            Property.string(
              key: 'name',
              value: useCaseName,
            ),
            Property(
              key: 'builder',
              instance: LambdaInstance(
                name: functionName,
                parameters: const [
                  'context',
                ],
              ),
            ),
          ],
        );
}
