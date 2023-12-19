import 'package:flutter/material.dart';

import '../../../next.dart';
import '../../state/state.dart';

import 'navigation_tree_tile.dart';
import 'tree_node.dart';

class NextNavigationTreeNode extends StatefulWidget {
  const NextNavigationTreeNode({
    super.key,
    required this.node,
    this.onNodeSelected,
  });

  final TreeNode node;
  final ValueChanged<TreeNode>? onNodeSelected;

  @override
  State<NextNavigationTreeNode> createState() => _NavigationTreeNodeState();
}

class _NavigationTreeNodeState extends State<NextNavigationTreeNode> {
  bool isExpanded = true;

  @override
  Widget build(BuildContext context) {
    final isLeaf = switch (widget.node) {
      TreeNode<Story>() => true,
      TreeNode<Component>() => widget.node.children.length == 1,
      _ => false,
    };

    return Column(
      children: [
        if (widget.node.parent != null) // non-root
          NextNavigationTreeTile(
            node: widget.node,
            isLeaf: isLeaf,
            isExpanded: isExpanded,
            isSelected: widget.node.path == WidgetbookState.of(context).path,
            onTap: () {
              if (!isLeaf) {
                setState(() => isExpanded = !isExpanded);
              } else if (widget.node is TreeNode<Story>) {
                widget.onNodeSelected?.call(widget.node);
              } else {
                // Redirect interactions to the use-case of the leaf component,
                // so that when it's clicked, the route is updated to the use-case
                // of the leaf component, and not the leaf component itself.
                final node = widget.node as TreeNode<Component>;
                widget.onNodeSelected?.call(node.children.first);
              }
            },
          ),
        if (!isLeaf)
          _SlideAnimator(
            forward: isExpanded,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.node.children.length,
              shrinkWrap: true,
              itemBuilder: (context, index) => NextNavigationTreeNode(
                node: widget.node.children[index],
                onNodeSelected: widget.onNodeSelected,
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
