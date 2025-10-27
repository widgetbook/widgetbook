import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../nodes/nodes.dart';
import 'navigation_tree_tile.dart';

@internal
class NavigationTreeNode extends StatefulWidget {
  const NavigationTreeNode({
    super.key,
    required this.node,
    this.selectedNode,
    this.onNodeSelected,
    this.enableLeafComponents = true,
  });

  final WidgetbookNode node;
  final WidgetbookNode? selectedNode;
  final ValueChanged<WidgetbookNode>? onNodeSelected;
  final bool enableLeafComponents;

  @override
  State<NavigationTreeNode> createState() => _NavigationTreeNodeState();
}

class _NavigationTreeNodeState extends State<NavigationTreeNode> {
  late bool isExpanded;

  @override
  void initState() {
    super.initState();

    isExpanded = widget.node.isInitiallyExpanded;
  }

  @override
  Widget build(BuildContext context) {
    const animationDuration = Duration(
      milliseconds: 200,
    );

    final isLeafComponent =
        widget.enableLeafComponents &&
        widget.node is WidgetbookComponent &&
        widget.node.children?.length == 1;

    // Redirect interactions to the use-case of the leaf component,
    // so that when it's clicked, the route is updated to the use-case
    // of the leaf component, and not the leaf component itself.
    final targetNode =
        isLeafComponent ? widget.node.children!.first : widget.node;

    return Column(
      children: [
        NavigationTreeTile(
          node: widget.node,
          isExpanded: isExpanded,
          isSelected: targetNode.path == widget.selectedNode?.path,
          enableLeafComponents: widget.enableLeafComponents,
          onTap: () {
            setState(() => isExpanded = !isExpanded);
            widget.onNodeSelected?.call(targetNode);
          },
        ),
        if (widget.node.children != null && !isLeafComponent)
          ClipRect(
            child: AnimatedSlide(
              duration: animationDuration,
              curve: Curves.easeInOut,
              offset: Offset(0, isExpanded ? 0 : -1),
              child: AnimatedAlign(
                duration: animationDuration,
                curve: Curves.easeInOut,
                alignment: Alignment.topCenter,
                heightFactor: isExpanded ? 1 : 0,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.node.children!.length,
                  shrinkWrap: true,
                  itemBuilder:
                      (context, index) => NavigationTreeNode(
                        node: widget.node.children![index],
                        selectedNode: widget.selectedNode,
                        onNodeSelected: widget.onNodeSelected,
                        enableLeafComponents: widget.enableLeafComponents,
                      ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
