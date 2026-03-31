import 'dart:async';

import 'package:flutter/material.dart';
// ignore: unnecessary_import flutter(<3.35.0)
import 'package:meta/meta.dart';

import '../framework/framework.dart';
import '../state/state.dart';
import 'category_tree_tile.dart';
import 'folder_tree_tile.dart';
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
  final Set<String> _toggled = {};

  static bool _isExpandedByDefault(TreeNode node) => node is! TreeNode<Story>;

  bool _filterNode(TreeNode node, String query) {
    final escapedQuery = RegExp.escape(query);
    final regex = RegExp(escapedQuery, caseSensitive: false);
    return node.name.contains(regex);
  }

  bool _isExpanded(TreeNode node) {
    return _toggled.contains(node.path)
        ? !_isExpandedByDefault(node)
        : _isExpandedByDefault(node);
  }

  List<TreeNode> _flattenTree(TreeNode root) {
    final result = <TreeNode>[];

    void walk(TreeNode node) {
      if (node.parent != null) {
        result.add(node);
        if (!_isExpanded(node)) return;
      }

      for (final child in node.children) {
        walk(child);
      }
    }

    walk(root);
    return result;
  }

  void _toggleExpanded(TreeNode node) {
    setState(() {
      final path = node.path;
      if (!_toggled.remove(path)) {
        _toggled.add(path);
      }
    });
  }

  Widget _buildTile(TreeNode node, String? selectedPath) {
    if (node.isCategory) {
      return CategoryTreeTile(
        node: node as TreeNode<Null>,
        onTap: () => _toggleExpanded(node),
      );
    }

    return FolderTreeTile(
      node: node,
      depth: node.depth,
      isTerminal: node.isTerminal,
      isExpanded: _isExpanded(node),
      isSelected: node.path == selectedPath,
      onExpanderTap: () => _toggleExpanded(node),
      onTap: () {
        if (!node.isClickable) {
          _toggleExpanded(node);
          return;
        }
        widget.onLeafNodeTap?.call(node);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = WidgetbookState.of(context);
    final query = state.query ?? '';
    final filteredRoot = query.isEmpty
        ? widget.root
        : widget.root.filter((node) => _filterNode(node, query));

    final entries = filteredRoot != null
        ? _flattenTree(filteredRoot)
        : <TreeNode>[];

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
          child: entries.isEmpty
              ? const Center(child: Text('No matches found'))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: entries.length,
                  itemBuilder: (context, index) =>
                      _buildTile(entries[index], state.path),
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
