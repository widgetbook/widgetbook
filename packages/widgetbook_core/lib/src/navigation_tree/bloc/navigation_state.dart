part of 'navigation_bloc.dart';

@freezed
class NavigationState with _$NavigationState {
  factory NavigationState({
    @Default([]) List<NavigationTreeNodeData> nodes,
    @Default([]) List<NavigationTreeNodeData> filteredNodes,
    NavigationTreeNodeData? selectedNode,
    @Default('') String searchQuery,
  }) = _NavigationState;
}
