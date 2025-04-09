import 'package:flutter/material.dart';

import '../../state/widgetbook_state.dart';
import '../nodes/nodes.dart';
import 'navigation_tree_node.dart';
import 'search_field.dart';
import 'stats_banner.dart';

class NavigationPanel extends StatefulWidget {
  const NavigationPanel({
    super.key,
    this.initialPath,
    this.onNodeSelected,
    required this.root,
  });

  final String? initialPath;
  final ValueChanged<WidgetbookNode>? onNodeSelected;
  final WidgetbookNode root;

  @override
  State<NavigationPanel> createState() => _NavigationPanelState();
}

class _NavigationPanelState extends State<NavigationPanel> {
  WidgetbookNode? selectedNode;

  bool filterNode(WidgetbookNode node, String query) {
    // Escapes all the special character which are treated differently in regex
    final escapedQuery = RegExp.escape(query);
    final regex = RegExp(escapedQuery, caseSensitive: false);
    return node.name.contains(regex);
  }

  @override
  void initState() {
    super.initState();
    selectedNode = widget.initialPath != null
        ? widget.root.find((child) => child.path == widget.initialPath)
        : null;
  }

  @override
  Widget build(BuildContext context) {
    final query = WidgetbookState.of(context).query ?? '';
    final filteredRoot = query.isEmpty
        ? widget.root
        : widget.root.filter((node) => filterNode(node, query)) ?? widget.root;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: SearchField(
            value: query,
            onChanged: WidgetbookState.of(context).updateQuery,
            onCleared: () => WidgetbookState.of(context).updateQuery(''),
          ),
        ),
        if (filteredRoot.children != null)
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              itemCount: filteredRoot.children!.length,
              itemBuilder: (context, index) => NavigationTreeNode(
                node: filteredRoot.children![index],
                selectedNode: selectedNode,
                onNodeSelected: (node) {
                  if (!node.isLeaf || node.path == selectedNode?.path) return;
                  setState(() => selectedNode = node);
                  widget.onNodeSelected?.call(node);
                },
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: StatsBanner(
            componentsCount: WidgetbookState.of(context).root.componentsCount,
            useCasesCount: WidgetbookState.of(context).root.useCasesCount,
          ),
        ),
      ],
    );
  }
}
