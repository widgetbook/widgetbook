import 'package:widgetbook_core/widgetbook_core.dart';

class WidgetbookFolder extends MultiChildNavigationNodeData {
  const WidgetbookFolder({
    required super.name,
    required List<MultiChildNavigationNodeData> children,
    super.isInitiallyExpanded = true,
  }) : super(
          children: children,
          type: NavigationNodeType.folder,
        );
}
