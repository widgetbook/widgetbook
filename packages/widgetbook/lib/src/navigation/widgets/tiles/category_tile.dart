import 'package:flutter/material.dart';

import '../../../../widgetbook.dart';
import 'component_tile.dart';
import 'folder_tile.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile({
    super.key,
    required this.node,
    required this.selectedPath,
  });

  final WidgetbookNode node;
  final String? selectedPath;

  bool get isSelected {
    final paths = selectedPath?.split('/') ?? [];
    final nodePaths = node.path.split('/');

    return paths.any((path) => nodePaths.contains(path));
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        node.name,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
      ),
      initiallyExpanded: isSelected,
      childrenPadding: const EdgeInsets.only(left: 16),
      children: node.children!
          .map(
            (child) => child.isLeaf
                ? ComponentTile(
                    node: child,
                    isSelected: child.path == selectedPath,
                  )
                : FolderTile(
                    node: child,
                    selectedPath: selectedPath,
                  ),
          )
          .toList(),
    );
  }
}
