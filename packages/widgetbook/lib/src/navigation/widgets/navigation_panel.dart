import 'package:flutter/material.dart';

import '../entities/entities.dart';
import 'navigation_tree.dart';
import 'search_field.dart';

class NavigationPanel extends StatefulWidget {
  const NavigationPanel({
    super.key,
    this.initialPath,
    this.onNodeSelected,
    required this.directories,
  });

  final String? initialPath;
  final ValueChanged<NavigationEntity>? onNodeSelected;
  final List<NavigationEntity> directories;

  @override
  State<NavigationPanel> createState() => _NavigationPanelState();
}

class _NavigationPanelState extends State<NavigationPanel> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          Expanded(
            child: NavigationTree(
              initialPath: widget.initialPath,
              onNodeSelected: widget.onNodeSelected,
              directories: widget.directories,
              searchQuery: searchQuery,
            ),
          ),
        ],
      ),
    );
  }
}
