import '../../models/widgetbook_use_case_data.dart';
import '../properties/property.dart';
import 'instance.dart';
import 'list_instance.dart';
import 'widgetbook_use_case_instance.dart';

/// An instance for WidgetElementInstance
class WidgetbookComponentInstance extends Instance {
  /// Creates a new instance of [WidgetbookComponentInstance]
  WidgetbookComponentInstance({
    required String name,
    required List<WidgetbookUseCaseData> stories,
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
            if (isExpanded)
              Property.bool(
                key: 'isInitiallyExpanded',
                value: true,
              ),
          ],
        );
}
