import 'package:widgetbook_core/widgetbook_core.dart';

class WidgetbookCategory extends MultiChildNavigationNodeData {
  const WidgetbookCategory({
    required super.name,
    required List<MultiChildNavigationNodeData> children,
    super.isInitiallyExpanded = true,
  }) : super(
          children: children,
          type: NavigationNodeType.category,
        );
}
