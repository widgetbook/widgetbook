import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

part 'navigation_tree_state.freezed.dart';

@freezed
class NavigationTreeState with _$NavigationTreeState {
  const factory NavigationTreeState({
    @Default(<MultiChildNavigationNodeData>[])
        List<MultiChildNavigationNodeData> nodes,
    @Default(<MultiChildNavigationNodeData>[])
        List<MultiChildNavigationNodeData> filteredNodes,
  }) = _NavigationTreeState;

  factory NavigationTreeState.unfiltered({
    required List<MultiChildNavigationNodeData> nodes,
  }) {
    return NavigationTreeState(
      nodes: nodes,
      filteredNodes: nodes,
    );
  }
}
