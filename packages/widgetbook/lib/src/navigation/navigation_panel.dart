import 'package:flutter/material.dart';
// ignore: unnecessary_import flutter(<3.35.0)
import 'package:meta/meta.dart';

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

  bool filterNode(TreeNode node, String query) {
    // Escapes all the special character which are treated differently in regex
    final escapedQuery = RegExp.escape(query);
    final regex = RegExp(escapedQuery, caseSensitive: false);
    return node.name.contains(regex);
  }

  @override
  Widget build(BuildContext context) {
    final query = WidgetbookState.of(context).query ?? '';
    final filteredRoot =
        query.isEmpty ? root : root.filter((node) => filterNode(node, query));

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (header != null)
            Padding(
              padding: const EdgeInsets.all(16),
              child: header!,
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
