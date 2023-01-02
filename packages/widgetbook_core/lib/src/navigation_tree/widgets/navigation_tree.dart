import 'package:flutter/material.dart';
import 'package:widgetbook_core/src/navigation_tree/navigation_tree.dart';

class NavigationTree extends StatelessWidget {
  const NavigationTree({
    super.key,
    required this.nodes,
    this.onNodeSelected,
    this.selectedNode,
  });

  final List<NavigationTreeNodeData> nodes;
  final NavigationTreeNodeData? selectedNode;
  final ValueChanged<NavigationTreeNodeData>? onNodeSelected;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      itemCount: nodes.length,
      itemBuilder: (context, index) => NavigationTreeNode(
        data: nodes[index],
        selectedNode: selectedNode,
        onNodeSelected: (NavigationTreeNodeData node) {
          onNodeSelected?.call(node);
        },
      ),
    );
  }
}
