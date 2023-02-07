import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

part 'navigation_bloc.freezed.dart';
part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationState()) {
    on<LoadNavigationTree>(_onLoadNavigationTree);
    on<SelectNavigationNode>(_onSelectNavigationNode);
    on<FilterNavigationNodes>(_onFilterNavigationNodes);
    on<ResetNodesFilter>(_onResetNodesFilter);
    on<SelectNavigationNodeByPath>(_onSelectNavigationNodeByPath);
  }

  void _onLoadNavigationTree(
    LoadNavigationTree event,
    Emitter<NavigationState> emit,
  ) {
    final nodes = _generateNodes(children: event.directories);
    final filteredNodes = _filterNodes(
      searchQuery: state.searchQuery,
      nodes: nodes,
    );

    emit(
      state.copyWith(
        nodes: nodes,
        filteredNodes: filteredNodes,
      ),
    );
  }

  void _onSelectNavigationNode(
    SelectNavigationNode event,
    Emitter<NavigationState> emit,
  ) {
    emit(
      state.copyWith(selectedNode: event.node),
    );
  }

  void _onFilterNavigationNodes(
    FilterNavigationNodes event,
    Emitter<NavigationState> emit,
  ) {
    final filteredNodes = _filterNodes(
      searchQuery: event.searchQuery,
      nodes: state.nodes,
    );

    emit(
      state.copyWith(
        searchQuery: event.searchQuery,
        filteredNodes: filteredNodes,
      ),
    );
  }

  void _onResetNodesFilter(
    ResetNodesFilter event,
    Emitter<NavigationState> emit,
  ) {
    emit(
      state.copyWith(
        searchQuery: '',
        filteredNodes: state.nodes,
      ),
    );
  }

  void _onSelectNavigationNodeByPath(
    SelectNavigationNodeByPath event,
    Emitter<NavigationState> emit,
  ) {
    final uri = Uri.parse(event.path);
    final finalPath = uri.queryParameters['path'];
    if (finalPath == null) return;
    final targetNode = _filterNodesByPath(finalPath);
    if (targetNode != null) {
      emit(
        state.copyWith(selectedNode: targetNode),
      );
    }
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
    for (final child in state.nodes) {
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
