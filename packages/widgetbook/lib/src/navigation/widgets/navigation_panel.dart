import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../state/widgetbook_state.dart';
import '../nodes/nodes.dart';
import 'navigation_tree_node.dart';
import 'navigation_tree_tile.dart';
import 'search_field.dart';
import 'stats_banner.dart';

@internal
class NavigationPanel extends StatefulWidget {
  const NavigationPanel({
    super.key,
    this.onNodeSelected,
    required this.root,
    this.header,
    this.headerPadding,
  });

  final ValueChanged<WidgetbookNode>? onNodeSelected;
  final WidgetbookNode root;

  /// An optional widget to display at the top of the navigation panel.
  /// This can be used for branding or additional information.
  final Widget? header;

  final EdgeInsetsGeometry? headerPadding;

  @override
  State<NavigationPanel> createState() => _NavigationPanelState();
}

class _NavigationPanelState extends State<NavigationPanel> {
  Timer? _debounce;
  WidgetbookNode? selectedNode;

  final _scrollController = ScrollController();

  /// Set on the currently selected [NavigationTreeTile], so it can be
  /// scrolled into view without hard-coding row heights.
  final _selectedItemKey = GlobalKey();

  /// Watched directly rather than read from a constructor parameter, because
  /// `DesktopLayout` renders this panel inside a `ResizableWidget`
  /// (`package:resizable_widget`), which builds its children once and never
  /// looks at them again — this panel is never rebuilt from above, so
  /// `didUpdateWidget` never fires for a path change that isn't a tap here.
  WidgetbookState? _watchedState;

  bool filterNode(WidgetbookNode node, String query) {
    // Escapes all the special character which are treated differently in regex
    final escapedQuery = RegExp.escape(query);
    final regex = RegExp(escapedQuery, caseSensitive: false);
    return node.name.contains(regex);
  }

  WidgetbookNode? _findSelectedNode(String? path) {
    return path != null
        ? widget.root.find((child) => child.path == path)
        : null;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // `initState` is too early to look up an InheritedWidget reliably.
    final state = WidgetbookState.of(context);
    if (identical(state, _watchedState)) return;

    _watchedState?.removeListener(_onStateChanged);
    _watchedState = state..addListener(_onStateChanged);

    // No prior position to animate from on the very first attach.
    _syncSelectedNode(initial: true, animate: false);
  }

  void _onStateChanged() => _syncSelectedNode();

  void _syncSelectedNode({bool initial = false, bool animate = true}) {
    final next = _findSelectedNode(_watchedState?.path);
    if (!initial && next?.path == selectedNode?.path) return;

    if (initial) {
      selectedNode = next;
    } else {
      setState(() => selectedNode = next);
    }
    _scrollToSelected(animate: animate);
  }

  /// Brings [selectedNode]'s tile into view: [_moveNear] gets it roughly
  /// into range, [_ensureSelectedVisible] centers it precisely once it
  /// exists — see their own doc comments.
  void _scrollToSelected({required bool animate}) {
    final path = selectedNode?.path;
    if (path == null) return;

    // A tile far down the list isn't built yet, so this needs a frame
    // before `_scrollController` has a position to move.
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      await _moveNear(path, animate: animate);

      if (!mounted) return;
      _ensureSelectedVisible();
    });
  }

  /// Moves to [path]'s row, computed from tree order (every row is
  /// [NavigationTreeTile.indentation] tall, and the tree is fully expanded
  /// by default, so the estimate is exact in the common case). Targets the
  /// row centered, matching [_ensureSelectedVisible]'s alignment — landing
  /// anywhere else made that second call visibly restart the scroll instead
  /// of being the no-op it's meant to be.
  Future<void> _moveNear(String path, {required bool animate}) async {
    if (!_scrollController.hasClients) return;

    final rows = _rowSearch(widget.root.children ?? const [], path);
    final targetIndex = rows.index;
    if (targetIndex == null) return;

    final estimate = targetIndex * NavigationTreeTile.indentation;
    final viewport = _scrollController.position.viewportDimension;
    final centered =
        estimate - viewport / 2 + NavigationTreeTile.indentation / 2;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final target = centered.clamp(0.0, maxScroll);

    if (!animate) {
      _scrollController.jumpTo(target);
      return;
    }

    // Scaled to distance, with a floor and a ceiling.
    final distance = (target - _scrollController.offset).abs();
    final durationMs = (distance / 2).clamp(150.0, 600.0).round();

    await _scrollController.animateTo(
      target,
      duration: Duration(milliseconds: durationMs),
      curve: Curves.easeInOut,
    );
  }

  /// Corrects for drift `_moveNear`'s estimate can't see, e.g. a manually
  /// collapsed ancestor folder. No-op if the tile isn't currently built.
  void _ensureSelectedVisible() {
    final selectedContext = _selectedItemKey.currentContext;
    if (selectedContext == null) return;

    Scrollable.ensureVisible(
      selectedContext,
      alignment: 0.5,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _watchedState?.removeListener(_onStateChanged);
    _debounce?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = WidgetbookState.of(context).query ?? '';
    final filteredRoot = query.isEmpty
        ? widget.root
        : widget.root.filter((node) => filterNode(node, query));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.header != null)
          Padding(
            padding: widget.headerPadding ?? const EdgeInsets.all(16),
            child: widget.header!,
          ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: SearchField(
            value: query,
            onCleared: () => WidgetbookState.of(context).updateQuery(''),
            onChanged: (value) {
              _debounce?.cancel();
              _debounce = Timer(
                const Duration(milliseconds: 100),
                () => WidgetbookState.of(context).updateQuery(value),
              );
            },
          ),
        ),
        Expanded(
          child: filteredRoot != null && filteredRoot.children != null
              ? ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  itemCount: filteredRoot.children!.length,
                  itemBuilder: (context, index) => NavigationTreeNode(
                    key: ObjectKey(filteredRoot.children![index]),
                    node: filteredRoot.children![index],
                    selectedNode: selectedNode,
                    selectedItemKey: _selectedItemKey,
                    onNodeSelected: (node) {
                      if (!node.isLeaf || node.path == selectedNode?.path) {
                        return;
                      }

                      // The caller applies this via updatePath, which
                      // reaches `_onStateChanged` like any other change.
                      widget.onNodeSelected?.call(node);
                    },
                    enableLeafComponents: WidgetbookState.of(
                      context,
                    ).enableLeafComponents,
                  ),
                )
              : const SizedBox(),
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

/// The target's row index, plus how many rows the searched subtree
/// renders in total (so siblings keep counting from the right offset).
typedef _RowSearch = ({int? index, int rowsConsumed});

/// Finds [targetPath]'s row index in the fully expanded tree, applying the
/// same single-use-case-component collapsing rule [NavigationTreeNode] uses
/// when rendering (see its `isLeafComponent`).
_RowSearch _rowSearch(List<WidgetbookNode> nodes, String targetPath) {
  var consumed = 0;

  for (final node in nodes) {
    final isLeafComponent =
        node is WidgetbookComponent && node.children?.length == 1;
    final effectivePath = isLeafComponent
        ? node.children!.first.path
        : node.path;

    if (effectivePath == targetPath) {
      return (index: consumed, rowsConsumed: consumed + 1);
    }
    consumed++;

    if (node.children != null && !isLeafComponent) {
      final child = _rowSearch(node.children!, targetPath);
      if (child.index != null) {
        return (
          index: consumed + child.index!,
          rowsConsumed: consumed + child.rowsConsumed,
        );
      }
      consumed += child.rowsConsumed;
    }
  }

  return (index: null, rowsConsumed: consumed);
}
