import 'package:flutter/material.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

class NavigationTreeNode extends StatefulWidget {
  const NavigationTreeNode({
    super.key,
    this.level = 0,
    required this.data,
    this.selectedNode,
    this.onNodeSelected,
  });

  final int level;
  final NavigationTreeNodeData data;
  final NavigationTreeNodeData? selectedNode;
  final ValueChanged<NavigationTreeNodeData>? onNodeSelected;

  @override
  State<NavigationTreeNode> createState() => _NavigationTreeNodeState();
}

class _NavigationTreeNodeState extends State<NavigationTreeNode> {
  late bool isExpanded;

  @override
  void initState() {
    isExpanded = widget.data.isInitiallyExpanded;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NavigationTreeItem(
          data: widget.data,
          isExpanded: isExpanded,
          level: widget.level,
          isSelected: widget.data.path == widget.selectedNode?.path,
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
            if (widget.data.isSelectable) {
              widget.onNodeSelected?.call(widget.data);
            }
          },
        ),
        ClipRect(
          child: AnimatedSlide(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            offset: Offset(0, isExpanded ? 0 : -1),
            child: AnimatedAlign(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              alignment: Alignment.bottomCenter,
              heightFactor: isExpanded ? 1 : 0,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.data.children.length,
                shrinkWrap: true,
                itemBuilder: (context, index) => NavigationTreeNode(
                  data: widget.data.children[index],
                  level: widget.level + 1,
                  selectedNode: widget.selectedNode,
                  onNodeSelected: widget.onNodeSelected,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
