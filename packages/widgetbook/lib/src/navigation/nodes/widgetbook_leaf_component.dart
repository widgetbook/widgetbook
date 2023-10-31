import 'widgetbook_component.dart';
import 'widgetbook_node.dart';
import 'widgetbook_use_case.dart';

/// A [WidgetbookComponent] with a single [WidgetbookUseCase].
class WidgetbookLeafComponent extends WidgetbookNode {
  WidgetbookLeafComponent({
    required super.name,
    required this.useCase,
  }) : super(
          children: [useCase],
        );

  final WidgetbookUseCase useCase;

  @override
  WidgetbookLeafComponent copyWith({
    String? name,
    List<WidgetbookNode>? children,
  }) {
    return this;
  }
}
