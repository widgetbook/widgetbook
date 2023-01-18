part of 'navigation_bloc.dart';

@freezed
class NavigationEvent with _$NavigationEvent {
  const factory NavigationEvent.load({
    required List<MultiChildNavigationNodeData> directories,
  }) = LoadNavigationTree;

  const factory NavigationEvent.selectNode({
    required NavigationTreeNodeData node,
  }) = SelectNavigationNode;

  const factory NavigationEvent.selectNodeByPath({
    required String path,
  }) = SelectNavigationNodeByPath;

  const factory NavigationEvent.filterNodes({
    required String searchQuery,
  }) = FilterNavigationNodes;

  const factory NavigationEvent.resetNodesFilters() = ResetNodesFilter;
}
