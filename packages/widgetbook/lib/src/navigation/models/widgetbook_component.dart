import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

class WidgetbookComponent extends MultiChildNavigationNodeData {
  const WidgetbookComponent({
    required super.name,
    required this.useCases,
    super.isInitiallyExpanded = true,
  }) : super(
          children: useCases,
          type: NavigationNodeType.component,
        );

  final List<WidgetbookUseCase> useCases;
}
