import 'dart:math';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../widgetbook.dart';
import '../theme/theme.dart';
import 'icons/component_icon.dart';
import 'icons/expander_icon.dart';
import 'icons/scenario_icon.dart';
import 'icons/story_icon.dart';
import 'tree_node.dart';

@internal
class FolderTreeTile extends StatelessWidget {
  const FolderTreeTile({
    super.key,
    required this.node,
    required this.depth,
    this.onTap,
    this.onExpanderTap,
    this.isTerminal = false,
    this.isExpanded = false,
    this.isSelected = false,
  });

  static const indentation = 24.0;

  final TreeNode node;
  final int depth;
  final VoidCallback? onTap;
  final VoidCallback? onExpanderTap;
  final bool isTerminal;
  final bool isExpanded;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(indentation);

    return Container(
      height: indentation,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: isSelected
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
              child: isTerminal
                  ? null
                  : InkWell(
                      onTap: onExpanderTap,
                      borderRadius: BorderRadius.circular(indentation / 2),
                      child: SizedBox(
                        width: indentation,
                        height: indentation,
                        child: ExpanderIcon(
                          isExpanded: isExpanded,
                        ),
                      ),
                    ),
            ),
            SizedBox(
              width: indentation,
              child: switch (node) {
                TreeNode<Story>() => const StoryIcon(),
                TreeNode<Scenario>() => const ScenarioIcon(),
                TreeNode<Component>() => const ComponentIcon(),
                TreeNode<List<DocBlock>>() => const Icon(Icons.book, size: 16),
                TreeNode<Null>() => const Icon(Icons.folder, size: 16),
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
