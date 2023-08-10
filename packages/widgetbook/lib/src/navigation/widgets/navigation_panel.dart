import 'package:flutter/material.dart';

import '../nodes/nodes.dart';
import 'navigation_tree_node.dart';
import 'search_field.dart';

class NavigationPanel extends StatefulWidget {
  const NavigationPanel({
    super.key,
    this.initialPath,
    this.onNodeSelected,
    required this.root,
  });

  final String? initialPath;
  final ValueChanged<TreeNode>? onNodeSelected;
  final TreeNode root;

  @override
  State<NavigationPanel> createState() => _NavigationPanelState();
}

class _NavigationPanelState extends State<NavigationPanel> {
  late TreeNode filteredRoot;
  TreeNode? selectedNode;
  String searchQuery = '';

  bool filterNode(TreeNode node) {
    final regex = RegExp(
      searchQuery,
      caseSensitive: false,
    );

    return node.name.contains(regex);
  }

  @override
  void initState() {
    super.initState();

    filteredRoot = widget.root;
    selectedNode = widget.initialPath != null
        ? widget.root.find((child) => child.path == widget.initialPath)
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: SearchField(
              searchValue: searchQuery,
              onSearchChanged: (value) {
                setState(() {
                  searchQuery = value;
                  filteredRoot = widget.root.filter(filterNode) ?? widget.root;
                });
              },
              onSearchCancelled: () {
                setState(() {
                  searchQuery = '';
                  filteredRoot = widget.root;
                });
              },
            ),
          ),
          Expanded(
            child: NavigationTreeNode(
              data: filteredRoot,
              selectedNode: selectedNode,
              onNodeSelected: (node) {
                if (node.path == selectedNode?.path) return;
                setState(() => selectedNode = node);
                widget.onNodeSelected?.call(node);
              },
            ),
          ),
        ],
      ),
    );
  }
}
