import '../models/use_case_metadata.dart';
import 'instance.dart';
import 'list_instance.dart';
import 'property.dart';
import 'widgetbook_use_case_instance.dart';

/// An instance for WidgetElementInstance
class WidgetbookComponentInstance extends Instance {
  /// Creates a new instance of [WidgetbookComponentInstance]
  WidgetbookComponentInstance({
    required String name,
    required List<UseCaseMetadata> stories,
    bool isExpanded = false,
  }) : super(
          name: 'WidgetbookComponent',
          properties: [
            Property.string(key: 'name', value: name),
            Property(
              key: 'useCases',
              instance: ListInstance<WidgetbookUseCaseInstance>(
                instances: stories
                    .map(
                      (useCase) => WidgetbookUseCaseInstance(
                        useCaseName: useCase.useCaseName,
                        functionName: useCase.name,
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        );
}
