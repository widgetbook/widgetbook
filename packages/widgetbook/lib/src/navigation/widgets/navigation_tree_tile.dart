import 'dart:math';

import 'package:flutter/material.dart';

import '../../../next.dart' as next;
import '../icons/icons.dart';
import '../icons/resolve_icon.dart';
import '../nodes/nodes.dart';

class NavigationTreeTile extends StatelessWidget {
  const NavigationTreeTile({
    super.key,
    required this.node,
    this.onTap,
    this.isExpanded = false,
    this.isSelected = false,
  });

  static const indentation = 24.0;

  final WidgetbookNode node;
  final VoidCallback? onTap;
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
              child: node.isLeaf || node is WidgetbookLeafComponent
                  ? null
                  : ExpanderIcon(
                      isExpanded: isExpanded,
                    ),
            ),
            SizedBox(
              width: indentation,
              child: resolveIcon(node),
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
            if (node is next.Story ||
                node is next.Component ||
                node is next.LeafComponent) ...{
              const Spacer(),
              const next.ExperimentalBadge(),
              const SizedBox(
                width: 8,
              ),
            },
          ],
        ),
      ),
    );
  }
}
