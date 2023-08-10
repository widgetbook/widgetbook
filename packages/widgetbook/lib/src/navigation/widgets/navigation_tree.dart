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
    required this.directories,
    this.searchQuery = '',
  });

  final NodeSelectedCallback? onNodeSelected;
  final String? initialPath;
  final List<TreeNode> directories;
  final String searchQuery;

  @override
  State<NavigationTree> createState() => NavigationTreeState();
}

class NavigationTreeState extends State<NavigationTree> {
  late final List<TreeNode> nodes;
  late List<TreeNode> filteredNodes;
  TreeNode? selectedNode;

  @override
  void initState() {
    super.initState();

    nodes = widget.directories;

    filteredNodes = widget.searchQuery.isNotEmpty
        ? _filterNodes(
            nodes: nodes,
            searchQuery: widget.searchQuery,
          )
        : nodes;

    selectedNode = widget.initialPath != null
        ? _filterNodesByPath(widget.initialPath!)
        : null;
  }

  @override
  void didUpdateWidget(NavigationTree oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.searchQuery != oldWidget.searchQuery) {
      filteredNodes = widget.searchQuery.isNotEmpty
          ? _filterNodes(
              nodes: nodes,
              searchQuery: widget.searchQuery,
            )
          : nodes;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      itemCount: filteredNodes.length,
      itemBuilder: (context, index) => NavigationTreeNode(
        data: filteredNodes[index],
        selectedNode: selectedNode,
        onNodeSelected: (node) {
          if (node.path == selectedNode?.path) return;
          setState(() => selectedNode = node);
          widget.onNodeSelected?.call(node.path, node);
        },
      ),
    );
  }

  List<TreeNode> _filterNodes({
    required String searchQuery,
    required List<TreeNode> nodes,
  }) {
    final filteredNodes = <TreeNode>[];
    for (final node in nodes) {
      final matchedNode = _filterNodeByQuery(node, searchQuery);
      if (matchedNode != null && !matchedNode.isLeaf) {
        filteredNodes.add(matchedNode);
      }
    }
    return filteredNodes;
  }

  TreeNode? _filterNodeByQuery(
    TreeNode node,
    String searchQuery,
  ) {
    if (node.isLeaf) return null;

    final regex = RegExp(searchQuery, caseSensitive: false);
    if (node.name.contains(regex) && !node.isLeaf) {
      return node;
    }

    final matchingChildren = <TreeNode>[];

    for (final child in node.children!) {
      if (!child.isLeaf) {
        final matchingChildNode = _filterNodeByQuery(child, searchQuery);
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
      return node.copyWith(
        children: matchingChildren,
      );
    }

    return null;
  }

  TreeNode? _filterNodesByPath(String path) {
    for (final child in nodes) {
      final matchedChild = _filterNodeByPath(child, path);
      if (matchedChild != null) {
        return matchedChild;
      }
    }
    return null;
  }

  TreeNode? _filterNodeByPath(
    TreeNode node,
    String targetPath,
  ) {
    if (node.path == targetPath) {
      return node;
    }
    for (final child in node.children!) {
      final matchedChild = _filterNodeByPath(child, targetPath);
      if (matchedChild != null) {
        return matchedChild;
      }
    }
    return null;
  }
}
