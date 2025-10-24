import 'dart:math';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../widgetbook_theme.dart';
import '../icons/icons.dart';
import '../icons/resolve_icon.dart';
import '../nodes/nodes.dart';

@internal
class NavigationTreeTile extends StatelessWidget {
  const NavigationTreeTile({
    super.key,
    required this.node,
    this.onTap,
    this.isExpanded = false,
    this.isSelected = false,
    this.enableLeafComponents = true,
  });

  static const indentation = 24.0;

  final WidgetbookNode node;
  final VoidCallback? onTap;
  final bool isExpanded;
  final bool isSelected;
  final bool enableLeafComponents;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(indentation);
    final isLeafComponent =
        enableLeafComponents &&
        node is WidgetbookComponent &&
        node.children?.length == 1;

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
              width: max(node.depth - 1, 0) * indentation,
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
          ],
        ),
      ),
    );
  }
}
