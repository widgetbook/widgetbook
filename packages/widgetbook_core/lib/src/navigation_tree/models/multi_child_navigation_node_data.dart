import 'package:widgetbook_core/src/navigation_tree/models/navigation_node_data_interface.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

class MultiChildNavigationNodeData extends NavigationNodeDataInterface {
  const MultiChildNavigationNodeData({
    required super.name,
    required super.children,
    required super.type,
    super.data,
    super.isInitiallyExpanded,
  });

  @override
  String toString() {
    return 'MultiChildNavigationNodeData('
        'name: $name, '
        'type: $type, '
        'data: $data, '
        'children: $children, '
        'isInitiallyExpanded: $isInitiallyExpanded '
        ')';
  }
}
