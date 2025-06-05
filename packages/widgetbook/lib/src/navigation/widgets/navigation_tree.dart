import 'package:flutter/material.dart';

import '../navigation.dart';
import '../nodes/widgetbook_node.dart';
import 'tiles/category_tile.dart';
import 'tiles/component_tile.dart';
import 'tiles/folder_tile.dart';

class NavigationTree extends StatelessWidget {
  const NavigationTree({
    super.key,
    required this.nodes,
    required this.selectedPath,
  });

  final List<WidgetbookNode> nodes;
  final String? selectedPath;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: nodes.length,
      itemBuilder: (context, index) {
        final node = nodes[index];
        final isSelected = node.path == selectedPath;

        return switch (node) {
          WidgetbookRoot() => const SizedBox.shrink(),
          WidgetbookPackage() => Text('package: ${node.name}'),
          WidgetbookComponent() || WidgetbookCategory() => CategoryTile(
              node: node,
              selectedPath: selectedPath,
            ),
          WidgetbookFolder() => FolderTile(
              node: node,
              selectedPath: selectedPath,
            ),
          WidgetbookUseCase() || WidgetbookLeafComponent() => ComponentTile(
              node: node,
              isSelected: isSelected,
            ),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }
}
