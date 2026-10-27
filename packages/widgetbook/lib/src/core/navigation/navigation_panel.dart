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
    this.onLeafNodeTap,
    required this.root,
    this.header,
    this.foldersExpandedByDefault = true,
  });

  final ValueChanged<TreeNode<dynamic>>? onLeafNodeTap;
  final TreeNode<Null> root;
  final Widget? header;
  final bool foldersExpandedByDefault;

  @override
  State<NavigationPanel> createState() => _NavigationPanelState();
}

class _NavigationPanelState extends State<NavigationPanel> {
  static const _listPadding = EdgeInsets.all(16);

  Timer? _debounce;
  final Set<String> _toggled = {};
  final ScrollController _scrollController = ScrollController();
  List<TreeNode> _entries = const [];
  String? _lastPath;
  bool _hasRevealedInitialPath = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final path = WidgetbookState.of(context).path;
    if (_hasRevealedInitialPath && path == _lastPath) return;

    final animate = _hasRevealedInitialPath;
    _hasRevealedInitialPath = true;
    _lastPath = path;
    _revealPath(path);
    _scrollToPath(path, animate: animate);
  }

  /// Expands all ancestors of [path], so that the node is visible in the tree.
  void _revealPath(String? path) {
    if (path == null) return;

    var node = widget.root.findByPath(path)?.parent;
    while (node != null && !node.isRoot) {
      if (!_isExpanded(node)) {
        _toggled.add(node.path);
      }
      node = node.parent;
    }
  }

  double _extentOf(TreeNode node) {
    return node.isCategory ? CategoryTreeTile.height : FolderTreeTile.height;
  }

  /// Centers the tile of [path] in the list, unless it is already fully
  /// visible. Runs after the next frame, once the list contains the tile.
  void _scrollToPath(String? path, {required bool animate}) {
    if (path == null) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || path != _lastPath || !_scrollController.hasClients) {
        return;
      }

      final index = _entries.indexWhere((node) => node.path == path);
      if (index < 0) return;

      final tileTop = _entries
          .take(index)
          .fold(_listPadding.top, (offset, node) => offset + _extentOf(node));
      final tileExtent = _extentOf(_entries[index]);

      final position = _scrollController.position;
      final viewport = position.viewportDimension;
      final isFullyVisible =
          tileTop >= position.pixels &&
          tileTop + tileExtent <= position.pixels + viewport;
      if (isFullyVisible) return;

      final target = (tileTop - (viewport - tileExtent) / 2).clamp(
        position.minScrollExtent,
        position.maxScrollExtent,
      );

      final isNearby = (target - position.pixels).abs() <= viewport;
      if (animate && isNearby) {
        _scrollController.animateTo(
          target,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
        );
      } else {
        _scrollController.jumpTo(target);
      }
    });
  }

  bool _isExpandedByDefault(TreeNode node) {
    if (node is TreeNode<Story>) return false;
    return widget.foldersExpandedByDefault;
  }

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

    final entries = _entries = filteredRoot != null
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
                  controller: _scrollController,
                  padding: _listPadding,
                  itemCount: entries.length,
                  itemExtentBuilder: (index, _) =>
                      index < entries.length ? _extentOf(entries[index]) : null,
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
    _scrollController.dispose();
    super.dispose();
  }
}
