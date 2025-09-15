import 'widgetbook_component.dart';
import 'widgetbook_use_case.dart';

/// A special [WidgetbookComponent] with a single [WidgetbookUseCase].
///
@Deprecated('Use [WidgetbookComponent] instead.')
class WidgetbookLeafComponent extends WidgetbookComponent {
  /// Creates a [WidgetbookLeafComponent] node.
  WidgetbookLeafComponent({
    required super.name,
    required WidgetbookUseCase useCase,
  }) : super(
         useCases: [useCase],
       );
}
