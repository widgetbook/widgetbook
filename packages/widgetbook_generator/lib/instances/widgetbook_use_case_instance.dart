import 'instance.dart';
import 'lambda_instance.dart';
import 'property.dart';

/// An instance for [WidgetbookUseCase]
class WidgetbookUseCaseInstance extends Instance {
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
                parameters: const ['context'],
              ),
            ),
          ],
        );
}
