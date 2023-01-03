import 'package:widgetbook_core/widgetbook_core.dart';

class FilterService {
  const FilterService();

  List<MultiChildNavigationNodeData> filterNodes(
    String searchQuery,
    List<MultiChildNavigationNodeData> nodes,
  ) {
    final filteredNodes = <MultiChildNavigationNodeData>[];
    for (final node in nodes) {
      final matchedNode = node.filterNode(searchQuery);
      if (matchedNode != null) {
        filteredNodes.add(matchedNode);
      }
    }
    return filteredNodes;
  }
}
