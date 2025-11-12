import 'dart:async';

import 'package:flutter/material.dart';
// ignore: unnecessary_import flutter(<3.35.0)
import 'package:meta/meta.dart';

import '../state/state.dart';
import 'navigation_tree_node.dart';
import 'search_field.dart';
import 'stats_banner.dart';
import 'tree_node.dart';

@internal
class NavigationPanel extends StatefulWidget {
  const NavigationPanel({
    super.key,
    this.initialPath,
    this.onLeafNodeTap,
    required this.root,
    this.header,
  });

  final String? initialPath;
  final ValueChanged<TreeNode<dynamic>>? onLeafNodeTap;
  final TreeNode<Null> root;
  final Widget? header;

  @override
  State<NavigationPanel> createState() => _NavigationPanelState();
}

class _NavigationPanelState extends State<NavigationPanel> {
  Timer? _debounce;

  bool filterNode(TreeNode node, String query) {
    // Escapes all the special character which are treated differently in regex
    final escapedQuery = RegExp.escape(query);
    final regex = RegExp(escapedQuery, caseSensitive: false);
    return node.name.contains(regex);
  }

  @override
  Widget build(BuildContext context) {
    final state = WidgetbookState.of(context);
    final query = state.query ?? '';
    final filteredRoot = query.isEmpty
        ? widget.root
        : widget.root.filter((node) => filterNode(node, query));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.header != null) widget.header!,
        Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
          ),
          child: SearchField(
            value: query,
            onCleared: () => state.updateQuery(''),
            onChanged: (value) {
              _debounce?.cancel();
              _debounce = Timer(
                const Duration(milliseconds: 100),
                () => state.updateQuery(value),
              );
            },
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: NavigationTreeNode(
                node: filteredRoot ?? widget.root,
                onLeafNodeTap: widget.onLeafNodeTap,
                enableLeafComponents: state.config.enableLeafComponents,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 8,
            right: 8,
            bottom: 8,
          ),
          child: StatsBanner(
            componentsCount: state.config.components.length,
            storiesCount: state.config.components.fold(
              0,
              (sum, component) => sum + component.stories.length,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}
