import 'package:widgetbook_core/widgetbook_core.dart';

class MultiChildNavigationNodeData extends NavigationTreeNodeData {
  MultiChildNavigationNodeData({
    required super.name,
    required super.children,
    required super.type,
    super.isInitiallyExpanded,
  });

  MultiChildNavigationNodeData updateChildren({
    required List<NavigationTreeNodeData> children,
  }) {
    return MultiChildNavigationNodeData(
      name: name,
      type: type,
      isInitiallyExpanded: isInitiallyExpanded,
      children: children,
    );
  }

  MultiChildNavigationNodeData? filterNode(String searchQuery) {
    final regex = RegExp(searchQuery, caseSensitive: false);
    if (name.contains(regex) && children.isNotEmpty) {
      return this;
    }
    final matchingChildren = <NavigationTreeNodeData>[];
    for (final child in children) {
      if (child is MultiChildNavigationNodeData) {
        final matchingChildNode = child.filterNode(searchQuery);
        if (matchingChildNode != null) {
          matchingChildren.add(matchingChildNode);
        }
      } else {
        if (child.name.contains(regex)) {
          matchingChildren.add(child);
        }
      }
    }
    if (matchingChildren.isNotEmpty) {
      return updateChildren(
        children: matchingChildren,
      );
    }
    return null;
  }
}
