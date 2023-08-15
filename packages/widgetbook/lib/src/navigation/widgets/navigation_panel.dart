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
  final ValueChanged<WidgetbookNode>? onNodeSelected;
  final WidgetbookNode root;

  @override
  State<NavigationPanel> createState() => _NavigationPanelState();
}

class _NavigationPanelState extends State<NavigationPanel> {
  late WidgetbookNode filteredRoot;
  WidgetbookNode? selectedNode;
  String searchQuery = '';

  bool filterNode(WidgetbookNode node) {
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
              value: searchQuery,
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                  filteredRoot = widget.root.filter(filterNode) ?? widget.root;
                });
              },
              onCleared: () {
                setState(() {
                  searchQuery = '';
                  filteredRoot = widget.root;
                });
              },
            ),
          ),
          if (filteredRoot.children != null)
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                itemCount: filteredRoot.children!.length,
                itemBuilder: (context, index) => NavigationTreeNode(
                  node: filteredRoot.children![index],
                  selectedNode: selectedNode,
                  onNodeSelected: (node) {
                    if (!node.isLeaf || node.path == selectedNode?.path) return;
                    setState(() => selectedNode = node);
                    widget.onNodeSelected?.call(node);
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
