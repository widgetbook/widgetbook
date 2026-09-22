import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
    this.foldersExpandedByDefault = true,
  });

  final String? initialPath;
  final ValueChanged<TreeNode<dynamic>>? onLeafNodeTap;
  final TreeNode<Null> root;
  final Widget? header;
  final bool foldersExpandedByDefault;

  @override
  State<NavigationPanel> createState() => _NavigationPanelState();
}

class _NavigationPanelState extends State<NavigationPanel> {
  Timer? _debounce;
  final Set<String> _toggled = {};
  final ScrollController _scrollController = ScrollController();

  /// Key of the currently selected tile, used to scroll it into view.
  final GlobalKey _selectedTileKey = GlobalKey();

  /// Nodes rendered by the list, as of the latest [build].
  List<TreeNode> _entries = const [];

  /// The path the panel last reacted to, used to detect external changes.
  String? _lastPath;

  /// Whether [_lastPath] was ever set; the first path is revealed without
  /// an animation, since it is the deep-linked one.
  bool _hasPath = false;

  @override
  void initState() {
    super.initState();
    _revealPath(widget.initialPath);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // [WidgetbookScope] is an [InheritedNotifier], so this runs whenever the
    // state changes, including when the path is updated from outside the
    // panel (e.g. a deep link or a knob that changes the route).
    final path = WidgetbookState.of(context).path;
    if (path == _lastPath) return;

    final isFirstPath = !_hasPath;
    _hasPath = true;
    _lastPath = path;
    _revealPath(path);
    _scrollToPath(path, animate: !isFirstPath);
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

  /// Scrolls the tile of [path] into view, once the list has rebuilt.
  ///
  /// [attempts] guards against frames in which the scrolling cannot happen
  /// yet, either because the list is not attached to the controller or the
  /// tile is outside the list's build range.
  void _scrollToPath(String? path, {required bool animate, int attempts = 5}) {
    if (path == null || attempts <= 0) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || path != _lastPath) return;

      if (!_scrollController.hasClients) {
        _scrollToPath(path, animate: animate, attempts: attempts - 1);
        return;
      }

      final index = _entries.indexWhere((node) => node.path == path);
      if (index < 0) return; // Filtered out by the search query.

      final position = _scrollController.position;
      final tileContext = _selectedTileKey.currentContext;

      if (tileContext == null) {
        // The tile is outside the list's build range; jump to its estimated
        // offset first, so that the next frame builds it.
        _scrollController.jumpTo(
          (index * FolderTreeTile.indentation).clamp(
            position.minScrollExtent,
            position.maxScrollExtent,
          ),
        );

        _scrollToPath(path, animate: false, attempts: attempts - 1);
        return;
      }

      if (_isFullyVisible(tileContext, position)) return;

      Scrollable.ensureVisible(
        tileContext,
        alignment: 0.5,
        duration: animate ? const Duration(milliseconds: 250) : Duration.zero,
        curve: Curves.easeInOut,
      );
    });
  }

  bool _isFullyVisible(BuildContext tileContext, ScrollPosition position) {
    final box = tileContext.findRenderObject();
    if (box is! RenderBox) return false;

    final viewport = RenderAbstractViewport.of(box);
    final leadingOffset = viewport.getOffsetToReveal(box, 0).offset;
    final trailingOffset = viewport.getOffsetToReveal(box, 1).offset;

    return position.pixels >= trailingOffset &&
        position.pixels <= leadingOffset;
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

    final isSelected = node.path == selectedPath;

    return FolderTreeTile(
      key: isSelected ? _selectedTileKey : null,
      node: node,
      depth: node.depth,
      isTerminal: node.isTerminal,
      isExpanded: _isExpanded(node),
      isSelected: isSelected,
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
    _scrollController.dispose();
    super.dispose();
  }
}
