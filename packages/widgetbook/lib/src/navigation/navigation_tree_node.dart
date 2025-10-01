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
  bool isExpanded = true;

  @override
  Widget build(BuildContext context) {
    final node = widget.node;
    final isCategory = node.isCategory;
    final isLeaf = switch (node) {
      TreeNode<Story>() => true,
      TreeNode<Component>() => node.children.length == 1,
      TreeNode<String>() => node.name == 'Docs',
      _ => false,
    };

    return Column(
      children: [
        if (node.parent != null) // non-root
          if (isCategory)
            CategoryTreeTile(
              node: node as TreeNode<String>,
              onTap: () {
                setState(() => isExpanded = !isExpanded);
              },
            )
          else
            FolderTreeTile(
              node: node,
              depth: widget.depth,
              isTerminal: isLeaf,
              isExpanded: isExpanded,
              isSelected: node.path == WidgetbookState.of(context).path,
              onTap: () {
                if (!isLeaf) {
                  setState(() => isExpanded = !isExpanded);
                } else if (node is TreeNode<Story> || node.name == 'Docs') {
                  widget.onLeafNodeTap?.call(node);
                } else {
                  // Redirect interactions to the story of the leaf component,
                  // so that when it's clicked, the route is updated to the story
                  // of the leaf component, and not the leaf component itself.
                  final componentNode = node as TreeNode<Component>;
                  widget.onLeafNodeTap?.call(
                    componentNode.children.first as TreeNode<Story>,
                  );
                }
              },
            ),
        if (!isLeaf)
          _SlideAnimator(
            forward: isExpanded,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: node.children.length,
              shrinkWrap: true,
              itemBuilder:
                  (context, index) => NavigationTreeNode(
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
