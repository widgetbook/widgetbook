import 'package:flutter/material.dart';

import '../../state/widgetbook_state.dart';
import '../nodes/nodes.dart';
import 'navigation_tree.dart';
import 'search_field.dart';
import 'stats_banner.dart';

class NavigationPanel extends StatefulWidget {
  const NavigationPanel({
    super.key,
    this.initialPath,
    this.onNodeSelected,
    required this.root,
    this.header,
  });

  final String? initialPath;
  final ValueChanged<WidgetbookNode>? onNodeSelected;
  final WidgetbookNode root;

  /// An optional widget to display at the top of the navigation panel.
  /// This can be used for branding or additional information.
  final Widget? header;

  @override
  State<NavigationPanel> createState() => _NavigationPanelState();
}

class _NavigationPanelState extends State<NavigationPanel> {
  late WidgetbookState _state;

  bool filterNode(WidgetbookNode node, String query) {
    // Escapes all the special character which are treated differently in regex
    final escapedQuery = RegExp.escape(query);
    final regex = RegExp(escapedQuery, caseSensitive: false);
    return node.name.contains(regex);
  }

  @override
  void didUpdateWidget(NavigationPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialPath != oldWidget.initialPath) {
      _state.open(widget.initialPath ?? '');
    }
  }

  @override
  Widget build(BuildContext context) {
    _state = WidgetbookState.of(context);
    final query = WidgetbookState.of(context).query ?? '';
    final filteredRoot = query.isEmpty
        ? widget.root
        : widget.root.filter((node) => filterNode(node, query)) ?? widget.root;

    return ListenableBuilder(
      listenable: _state,
      builder: (context, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (widget.header != null)
              Padding(
                padding: const EdgeInsets.all(16),
                child: widget.header!,
              ),
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
                child: Theme(
                  data: Theme.of(context).copyWith(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    splashFactory: NoSplash.splashFactory,
                    hoverColor: Colors.transparent,
                  ),
                  child: NavigationTree(
                    nodes: filteredRoot.children!,
                    selectedPath: _state.path,
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: StatsBanner(
                componentsCount:
                    WidgetbookState.of(context).root.componentsCount,
                useCasesCount: WidgetbookState.of(context).root.useCasesCount,
              ),
            ),
          ],
        );
      },
    );
  }
}
