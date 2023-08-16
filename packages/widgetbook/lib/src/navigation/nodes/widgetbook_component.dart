import 'widgetbook_node.dart';
import 'widgetbook_use_case.dart';

class WidgetbookComponent extends WidgetbookNode {
  WidgetbookComponent({
    required super.name,
    required this.useCases,
    super.isInitiallyExpanded,
  }) : super(
          children: useCases,
        );

  final List<WidgetbookUseCase> useCases;

  @override
  WidgetbookComponent copyWith({
    String? name,
    List<WidgetbookNode>? children,
  }) {
    return WidgetbookComponent(
      name: name ?? this.name,
      useCases: children?.cast<WidgetbookUseCase>() ?? this.useCases,
      isInitiallyExpanded: isInitiallyExpanded,
    );
  }
}
