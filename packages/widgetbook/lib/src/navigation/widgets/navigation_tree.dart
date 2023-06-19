import 'package:flutter/material.dart';

import '../entities/entities.dart';
import 'navigation_tree_node.dart';

class NavigationTree extends StatefulWidget {
  const NavigationTree({
    super.key,
    this.onNodeSelected,
    this.initialPath,
    required this.directories,
    this.searchQuery = '',
  });

  final ValueChanged<NavigationEntity>? onNodeSelected;
  final String? initialPath;
  final List<NavigationEntity> directories;
  final String searchQuery;

  @override
  State<NavigationTree> createState() => NavigationTreeState();
}

class NavigationTreeState extends State<NavigationTree> {
  late List<NavigationEntity> filteredNodes;
  NavigationEntity? selectedNode;

  @override
  void initState() {
    super.initState();

    filteredNodes = widget.searchQuery.isNotEmpty
        ? _filterNodes(
            nodes: widget.directories,
            searchQuery: widget.searchQuery,
          )
        : widget.directories;

    selectedNode = widget.initialPath != null
        ? _filterNodesByPath(widget.initialPath!)
        : null;
  }

  @override
  void didUpdateWidget(NavigationTree oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.searchQuery != oldWidget.searchQuery) {
      filteredNodes = widget.searchQuery.isNotEmpty
          ? _filterNodes(
              nodes: widget.directories,
              searchQuery: widget.searchQuery,
            )
          : widget.directories;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      itemCount: filteredNodes.length,
      itemBuilder: (context, index) => NavigationTreeNode(
        data: filteredNodes[index],
        selectedNode: selectedNode,
        onNodeSelected: (node) {
          if (node.path == selectedNode?.path) return;
          setState(() => selectedNode = node);
          widget.onNodeSelected?.call(node);
        },
      ),
    );
  }

  List<NavigationEntity> _filterNodes({
    required String searchQuery,
    required List<NavigationEntity> nodes,
  }) {
    final filteredNodes = <NavigationEntity>[];
    for (final node in nodes) {
      final matchedNode = _filterNodeByQuery(node, searchQuery);
      if (matchedNode != null && node.children != null) {
        filteredNodes.add(matchedNode);
      }
    }
    return filteredNodes;
  }

  NavigationEntity? _filterNodeByQuery(
    NavigationEntity node,
    String searchQuery,
  ) {
    final regex = RegExp(searchQuery, caseSensitive: false);
    if (node.name.contains(regex) && node.isExpandable) {
      return node;
    }

    final matchingChildren = <NavigationEntity>[];
    for (final child in node.children ?? <NavigationEntity>[]) {
      if (node.isExpandable) {
        final matchingChildNode = _filterNodeByQuery(child, searchQuery);
        if (matchingChildNode != null) {
          matchingChildren.add(matchingChildNode);
        }
      } else {
        if (child.name.contains(regex)) {
          matchingChildren.add(child);
        }
      }
    }
    if (matchingChildren.isNotEmpty) {
      return node.copyWith(
        children: matchingChildren,
      );
    }
    return null;
  }

  NavigationEntity? _filterNodesByPath(String path) {
    for (final child in widget.directories) {
      final matchedChild = _filterNodeByPath(child, path);
      if (matchedChild != null) {
        return matchedChild;
      }
    }

    return null;
  }

  NavigationEntity? _filterNodeByPath(
    NavigationEntity node,
    String targetPath,
  ) {
    if (node.path == targetPath) {
      return node;
    }

    for (final child in node.children ?? <NavigationEntity>[]) {
      final matchedChild = _filterNodeByPath(child, targetPath);

      if (matchedChild != null) {
        return matchedChild;
      }
    }

    return null;
  }
}
