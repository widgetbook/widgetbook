import '../properties/property.dart';
import 'instance.dart';
import 'lambda_instance.dart';

/// An instance for WidgetbookUseCase
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
