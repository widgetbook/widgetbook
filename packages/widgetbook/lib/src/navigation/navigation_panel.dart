import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../core/core.dart';
import '../state/state.dart';
import 'navigation_tree_node.dart';
import 'search_field.dart';
import 'stats_banner.dart';
import 'tree_node.dart';

@internal
class NavigationPanel extends StatelessWidget {
  const NavigationPanel({
    super.key,
    this.initialPath,
    this.onStoryTap,
    required this.root,
    this.header,
  });

  final String? initialPath;
  final ValueChanged<TreeNode<Story>>? onStoryTap;
  final TreeNode<Null> root;
  final Widget? header;

  @override
  Widget build(BuildContext context) {
    final query = WidgetbookState.of(context).query ?? '';
    final filteredRoot = root.filter(
      (node) {
        final regex = RegExp(query, caseSensitive: false);
        return query.isEmpty || node.name.contains(regex);
      },
    );

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          if (header != null)
            Padding(
              padding: const EdgeInsets.all(16),
              child: header,
            ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SearchField(
              value: query,
              onChanged: WidgetbookState.of(context).updateQuery,
              onCleared: () => WidgetbookState.of(context).updateQuery(''),
            ),
          ),
          Expanded(
            child: NavigationTreeNode(
              node: filteredRoot ?? root,
              onStoryTap: onStoryTap,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: StatsBanner(
              componentsCount: WidgetbookState.of(context).components.length,
              storiesCount: WidgetbookState.of(context).components.fold(
                0,
                (sum, component) => sum + component.stories.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
