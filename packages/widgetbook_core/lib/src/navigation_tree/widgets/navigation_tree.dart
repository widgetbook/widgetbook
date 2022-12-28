import 'package:flutter/material.dart';
import 'package:widgetbook_core/src/navigation_tree/navigation_tree.dart';

class NavigationTree extends StatefulWidget {
  const NavigationTree({
    super.key,
    required this.nodes,
    this.onNodeSelected,
  });

  final List<NavigationTreeNodeData> nodes;
  final ValueChanged<NavigationTreeNodeData>? onNodeSelected;

  @override
  State<NavigationTree> createState() => _NavigationTreeState();
}

class _NavigationTreeState extends State<NavigationTree> {
  String? selectedNodeId;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.nodes.length,
      itemBuilder: (context, index) => NavigationTreeNode(
        data: widget.nodes[index],
        selectedNodeId: selectedNodeId,
        onNodeSelected: (NavigationTreeNodeData node) {
          setState(() {
            selectedNodeId = node.id;
          });
          widget.onNodeSelected?.call(node);
        },
      ),
    );
  }
}
