import 'package:widgetbook_core/widgetbook_core.dart';

class LeafNavigationNodeData extends NavigationTreeNodeData {
  LeafNavigationNodeData({
    required super.name,
    required super.type,
    super.isInitiallyExpanded,
  }) : super(children: []);
}
