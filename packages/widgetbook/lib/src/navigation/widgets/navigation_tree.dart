import 'package:flutter/material.dart';

import '../navigation.dart';
import 'tiles/category_tile.dart';
import 'tiles/component_tile.dart';

class NavigationTree extends StatelessWidget {
  const NavigationTree({
    super.key,
    required this.nodes,
    required this.selectedPath,
    required this.searchQuery,
  });

  final List<WidgetbookNode> nodes;
  final String? selectedPath;
  final String? searchQuery;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: nodes.length,
      itemBuilder: (context, index) {
        final node = nodes[index];
        final isSelected = node.path == selectedPath;

        return switch (node) {
          WidgetbookFolder() ||
          WidgetbookComponent() ||
          WidgetbookCategory() =>
            CategoryTile(
              node: node,
              selectedPath: selectedPath,
              searchQuery: searchQuery,
              isExpanded: true,
            ),
          WidgetbookUseCase() || WidgetbookLeafComponent() => ComponentTile(
              node: node,
              isSelected: isSelected,
            ),
          WidgetbookPackage() ||
          WidgetbookRoot() ||
          _ =>
            const SizedBox.shrink(),
        };
      },
    );
  }
}
