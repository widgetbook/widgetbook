import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../theme/theme.dart';
import 'folder_tree_tile.dart';

@internal
class AtlasTreeTile extends StatelessWidget {
  const AtlasTreeTile({
    super.key,
    required this.isSelected,
    required this.onTap,
  });

  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    const indentation = FolderTreeTile.indentation;
    final borderRadius = BorderRadius.circular(indentation);

    return Container(
      height: FolderTreeTile.height,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: isSelected
            ? WidgetbookTheme.of(context).colorScheme.secondaryContainer
            : null,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        child: const Row(
          children: [
            SizedBox(
              width: indentation,
              child: Icon(Icons.account_tree_outlined, size: 16),
            ),
            SizedBox(width: 4),
            Expanded(child: Text('Atlas')),
          ],
        ),
      ),
    );
  }
}
