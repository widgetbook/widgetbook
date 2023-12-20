import 'dart:math';

import 'package:flutter/material.dart';

import '../../../next.dart';
import 'icons/component_icon.dart';
import 'icons/expander_icon.dart';
import 'icons/story_icon.dart';
import 'tree_node.dart';

class NextNavigationTreeTile extends StatelessWidget {
  const NextNavigationTreeTile({
    super.key,
    required this.node,
    this.onTap,
    this.isLeaf = false,
    this.isExpanded = false,
    this.isSelected = false,
  });

  static const indentation = 24.0;

  final TreeNode node;
  final VoidCallback? onTap;
  final bool isLeaf;
  final bool isExpanded;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(indentation);
    final categoryRegex = RegExp(r'^\[(.+)\]$');
    final isCategory = categoryRegex.hasMatch(node.name);
    final match = categoryRegex.firstMatch(node.name);
    final nodeName = isCategory ? match!.group(1)! : node.name;

    return Container(
      height: indentation,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: isSelected
            ? Theme.of(context).colorScheme.secondaryContainer
            : null,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        child: Row(
          children: [
            SizedBox(
              width: max(node.depth - 1, 0) * indentation,
            ),
            SizedBox(
              width: indentation,
              child: isLeaf
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
                TreeNode<String>() => isCategory
                    ? const Icon(Icons.auto_awesome_mosaic, size: 16)
                    : const Icon(Icons.folder, size: 16),
                _ => const SizedBox(),
              },
            ),
            const SizedBox(
              width: 4,
            ),
            Expanded(
              child: Text(
                nodeName,
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
