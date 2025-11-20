import 'package:flutter/material.dart';

import '../core/core.dart';
import '../state/state.dart';

import 'category_tree_tile.dart';
import 'folder_tree_tile.dart';
import 'tree_node.dart';

class NavigationTreeNode extends StatefulWidget {
  const NavigationTreeNode({
    super.key,
    required this.node,
    this.depth = 0,
    this.onLeafNodeTap,
  });

  final TreeNode node;
  final int depth;
  final ValueChanged<TreeNode<dynamic>>? onLeafNodeTap;

  @override
  State<NavigationTreeNode> createState() => _NavigationTreeNodeState();
}

class _NavigationTreeNodeState extends State<NavigationTreeNode> {
  late bool isExpanded;

  @override
  void initState() {
    super.initState();

    // Stories are always collapsed by default
    isExpanded = widget.node is! TreeNode<Story>;
  }

  void toggleExpanded() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = WidgetbookState.of(context);
    final node = widget.node;
    final isCategory = node.isCategory;

    final isClickable = switch (node) {
      TreeNode<String>() => true, // docs
      TreeNode<Scenario>() => true,
      TreeNode<Story>() => true,
      _ => false,
    };

    return Column(
      children: [
        if (node.parent != null) // non-root
          if (isCategory)
            CategoryTreeTile(
              node: node as TreeNode<Null>,
              onTap: () {
                setState(() => isExpanded = !isExpanded);
              },
            )
          else
            FolderTreeTile(
              node: node,
              depth: widget.depth,
              isTerminal: isClickable,
              isExpanded: isExpanded,
              isSelected: node.path == state.path,
              onExpanderTap: toggleExpanded,
              onTap: () {
                if (!isClickable) {
                  toggleExpanded();
                  return;
                }

                widget.onLeafNodeTap?.call(node);
              },
            ),
        if (node.children.isNotEmpty)
          _SlideAnimator(
            forward: isExpanded,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: node.children.length,
              shrinkWrap: true,
              itemBuilder: (context, index) => NavigationTreeNode(
                depth: isCategory ? widget.depth : widget.depth + 1,
                node: node.children[index],
                onLeafNodeTap: widget.onLeafNodeTap,
              ),
            ),
          ),
      ],
    );
  }
}

class _SlideAnimator extends StatelessWidget {
  const _SlideAnimator({
    required this.forward,
    required this.child,
  });

  final bool forward;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    const animationDuration = Duration(
      milliseconds: 200,
    );

    return ClipRect(
      child: AnimatedSlide(
        duration: animationDuration,
        curve: Curves.easeInOut,
        offset: Offset(0, forward ? 0 : -1),
        child: AnimatedAlign(
          duration: animationDuration,
          curve: Curves.easeInOut,
          alignment: Alignment.topCenter,
          heightFactor: forward ? 1 : 0,
          child: child,
        ),
      ),
    );
  }
}
