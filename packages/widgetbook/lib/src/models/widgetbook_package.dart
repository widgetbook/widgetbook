import 'package:widgetbook_core/widgetbook_core.dart';

class WidgetbookPackage extends MultiChildNavigationNodeData {
  const WidgetbookPackage({
    required super.name,
    required List<MultiChildNavigationNodeData> children,
    super.isInitiallyExpanded = true,
  }) : super(
          children: children,
          type: NavigationNodeType.package,
        );
}
