import 'package:flutter/material.dart';

import '../navigation.dart';

typedef NodeSelectedCallback = void Function(
  String path,
  TreeNode node,
);

class NavigationTree extends StatefulWidget {
  const NavigationTree({
    super.key,
    this.onNodeSelected,
    this.initialPath,
    required this.root,
    this.searchQuery = '',
  });

  final NodeSelectedCallback? onNodeSelected;
  final String? initialPath;
  final TreeNode root;
  final String searchQuery;

  @override
  State<NavigationTree> createState() => NavigationTreeState();
}

class NavigationTreeState extends State<NavigationTree> {
  late TreeNode filteredRoot;
  TreeNode? selectedNode;

  bool filterNode(TreeNode node) {
    final regex = RegExp(
      widget.searchQuery,
      caseSensitive: false,
    );

    return node.name.contains(regex);
  }

  @override
  void initState() {
    super.initState();

    filteredRoot = widget.root.filter(filterNode) ?? widget.root;
    selectedNode = widget.initialPath != null
        ? widget.root.find((child) => child.path == widget.initialPath)
        : null;
  }

  @override
  void didUpdateWidget(NavigationTree oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.searchQuery != oldWidget.searchQuery) {
      filteredRoot = widget.root.filter(filterNode) ?? widget.root;
    }
  }

  @override
  Widget build(BuildContext context) {
    return NavigationTreeNode(
      data: filteredRoot,
      selectedNode: selectedNode,
      onNodeSelected: (node) {
        if (node.path == selectedNode?.path) return;
        setState(() => selectedNode = node);
        widget.onNodeSelected?.call(node.path, node);
      },
    );
  }
}
