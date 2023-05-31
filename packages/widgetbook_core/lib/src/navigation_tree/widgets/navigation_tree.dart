import 'package:flutter/material.dart';

import '../navigation_tree.dart';

typedef NodeSelectedCallback = void Function(
  String path,
  dynamic data,
);

class NavigationTree extends StatefulWidget {
  const NavigationTree({
    super.key,
    this.onNodeSelected,
    this.initialPath,
    required this.directories,
    this.searchQuery = '',
  });

  final NodeSelectedCallback? onNodeSelected;
  final String? initialPath;
  final List<MultiChildNavigationNodeData> directories;
  final String searchQuery;

  @override
  State<NavigationTree> createState() => _NavigationTreeState();
}

class _NavigationTreeState extends State<NavigationTree> {
  late final List<NavigationTreeNodeData> nodes;
  late final List<NavigationTreeNodeData> filteredNodes;
  NavigationTreeNodeData? selectedNode;

  @override
  void initState() {
    super.initState();

    nodes = _generateNodes(
      children: widget.directories,
    );

    filteredNodes = widget.searchQuery.isEmpty
        ? _filterNodes(
            nodes: nodes,
            searchQuery: widget.searchQuery,
          )
        : nodes;

    selectedNode = widget.initialPath != null
        ? _filterNodesByPath(widget.initialPath!)
        : null;
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
          setState(() => selectedNode = node);
          widget.onNodeSelected?.call(node.path, node.data);
        },
      ),
    );
  }

  List<NavigationTreeNodeData> _generateNodes({
    required List<NavigationNodeDataInterface> children,
    List<String> currentPathSegments = const [],
  }) {
    final nodes = <NavigationTreeNodeData>[];
    for (final child in children) {
      final pathSegments = [...currentPathSegments, child.name];
      nodes.add(
        NavigationTreeNodeData(
          path: pathSegments.join('/').replaceAll(' ', '-').toLowerCase(),
          name: child.name,
          type: child.type,
          data: child.data,
          isInitiallyExpanded: child.isInitiallyExpanded,
          children: child.children.isNotEmpty
              ? _generateNodes(
                  children: child.children,
                  currentPathSegments: pathSegments,
                )
              : [],
        ),
      );
    }
    return nodes;
  }

  List<NavigationTreeNodeData> _filterNodes({
    required String searchQuery,
    required List<NavigationTreeNodeData> nodes,
  }) {
    final filteredNodes = <NavigationTreeNodeData>[];
    for (final node in nodes) {
      final matchedNode = _filterNodeByQuery(node, searchQuery);
      if (matchedNode != null && matchedNode.isExpandable) {
        filteredNodes.add(matchedNode);
      }
    }
    return filteredNodes;
  }

  NavigationTreeNodeData? _filterNodeByQuery(
    NavigationTreeNodeData node,
    String searchQuery,
  ) {
    final regex = RegExp(searchQuery, caseSensitive: false);
    if (node.name.contains(regex) && node.children.isNotEmpty) {
      return node;
    }
    final matchingChildren = <NavigationTreeNodeData>[];
    for (final child in node.children) {
      if (child.isExpandable) {
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

  NavigationTreeNodeData? _filterNodesByPath(String path) {
    for (final child in nodes) {
      final matchedChild = _filterNodeByPath(child, path);
      if (matchedChild != null) {
        return matchedChild;
      }
    }
    return null;
  }

  NavigationTreeNodeData? _filterNodeByPath(
    NavigationTreeNodeData node,
    String targetPath,
  ) {
    if (node.path == targetPath) {
      return node;
    }
    for (final child in node.children) {
      final matchedChild = _filterNodeByPath(child, targetPath);
      if (matchedChild != null) {
        return matchedChild;
      }
    }
    return null;
  }
}
