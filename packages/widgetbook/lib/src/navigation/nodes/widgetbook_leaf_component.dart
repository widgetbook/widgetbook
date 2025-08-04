import 'widgetbook_component.dart';
import 'widgetbook_node.dart';
import 'widgetbook_use_case.dart';

/// A special [WidgetbookComponent] with a single [WidgetbookUseCase].
/// In the navigation tree, this is represented as a "component" but acts like
/// a "use-case".
class WidgetbookLeafComponent extends WidgetbookNode {
  /// Creates a [WidgetbookLeafComponent] node.
  WidgetbookLeafComponent({
    required super.name,
    required this.useCase,
  }) : super(
         children: [useCase],
       );

  /// The [WidgetbookUseCase] that this leaf component represents.
  final WidgetbookUseCase useCase;

  @override
  WidgetbookLeafComponent copyWith({
    String? name,
    List<WidgetbookNode>? children,
  }) {
    return this;
  }
}
