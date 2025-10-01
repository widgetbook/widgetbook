import 'dart:math';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../core/core.dart';
import '../theme/theme.dart';
import 'icons/component_icon.dart';
import 'icons/expander_icon.dart';
import 'icons/story_icon.dart';
import 'tree_node.dart';

@internal
class FolderTreeTile extends StatelessWidget {
  const FolderTreeTile({
    super.key,
    required this.node,
    required this.depth,
    this.onTap,
    this.isTerminal = false,
    this.isExpanded = false,
    this.isSelected = false,
  });

  static const indentation = 24.0;

  final TreeNode node;
  final int depth;
  final VoidCallback? onTap;
  final bool isTerminal;
  final bool isExpanded;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(indentation);
    final isLeafComponent =
        node is TreeNode<Component> && node.children.length == 1;

    return Container(
      height: indentation,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color:
            isSelected
                ? WidgetbookTheme.of(context).colorScheme.secondaryContainer
                : null,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        child: Row(
          children: [
            SizedBox(
              width: max(depth - 1, 0) * indentation,
            ),
            SizedBox(
              width: indentation,
              child:
                  node.isLeaf || isLeafComponent
                      ? null
                      : ExpanderIcon(
                        isExpanded: isExpanded,
                      ),
            ),
            SizedBox(
              width: indentation,
              child: switch (node) {
                TreeNode<Story>() => const StoryIcon(),
                TreeNode<Component>() => const ComponentIcon(),
                TreeNode<String>() =>
                  node.name == 'Docs'
                      ? const Icon(Icons.book, size: 16)
                      : const Icon(Icons.folder, size: 16),
                _ => const SizedBox(),
              },
            ),
            const SizedBox(
              width: 4,
            ),
            Expanded(
              child: Text(
                node.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
