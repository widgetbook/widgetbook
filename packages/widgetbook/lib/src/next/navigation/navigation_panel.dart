import 'package:flutter/material.dart';

import '../../../next.dart';
import '../../state/state.dart';
import 'tree_node.dart';

class NextNavigationPanel extends StatelessWidget {
  const NextNavigationPanel({
    super.key,
    required this.root,
  });

  final TreeNode<Null> root;

  @override
  Widget build(BuildContext context) {
    return NavigationList(
      node: root,
    );
  }
}

class NavigationList extends StatelessWidget {
  const NavigationList({
    super.key,
    this.depth = 0,
    required this.node,
  });

  final int depth;
  final TreeNode node;

  @override
  Widget build(BuildContext context) {
    final isLeafComponent = node.data is Component && node.children.length == 1;
    final children = node.children;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (node is! TreeNode<Null>)
          InkWell(
            child: Text(node.name),
            onTap: () {
              if (node is TreeNode<Story>) {
                WidgetbookState.of(context).updatePath(node.path);
              } else if (isLeafComponent) {
                WidgetbookState.of(context).updatePath(children.first.path);
              }
            },
          ),
        if (!isLeafComponent && node.children.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(
              left: depth * 8,
            ),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: children.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final node = children[index];
                return NavigationList(
                  depth: depth + 1,
                  node: node,
                );
              },
            ),
          ),
      ],
    );
  }
}
