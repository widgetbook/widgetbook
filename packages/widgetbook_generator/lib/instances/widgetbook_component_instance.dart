import '../models/use_case_metadata.dart';
import 'instance.dart';
import 'list_instance.dart';
import 'property.dart';
import 'widgetbook_use_case_instance.dart';

/// An instance for [WidgetbookComponent]
class WidgetbookComponentInstance extends Instance {
  WidgetbookComponentInstance({
    required String name,
    required List<UseCaseMetadata> useCases,
    bool isExpanded = false,
  }) : super(
          name: 'WidgetbookComponent',
          properties: [
            Property.string(
              key: 'name',
              value: name,
            ),
            Property(
              key: 'useCases',
              instance: ListInstance<WidgetbookUseCaseInstance>(
                instances: useCases
                    .map(
                      (useCase) => WidgetbookUseCaseInstance(
                        useCaseName: useCase.name,
                        functionName: useCase.functionName,
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        );
}
