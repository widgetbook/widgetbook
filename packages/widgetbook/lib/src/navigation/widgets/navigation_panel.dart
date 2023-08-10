import 'package:flutter/material.dart';

import '../nodes/nodes.dart';
import 'navigation_tree.dart';
import 'search_field.dart';

class NavigationPanel extends StatefulWidget {
  const NavigationPanel({
    super.key,
    this.initialPath,
    this.onNodeSelected,
    required this.root,
  });

  final String? initialPath;
  final NodeSelectedCallback? onNodeSelected;
  final TreeNode root;

  @override
  State<NavigationPanel> createState() => _NavigationPanelState();
}

class _NavigationPanelState extends State<NavigationPanel> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 50, maxWidth: 300),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: SearchField(
                searchValue: searchQuery,
                onSearchChanged: (value) {
                  setState(() => searchQuery = value);
                },
                onSearchCancelled: () {
                  setState(() => searchQuery = '');
                },
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: NavigationTree(
                initialPath: widget.initialPath,
                onNodeSelected: widget.onNodeSelected,
                root: widget.root,
                searchQuery: searchQuery,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
