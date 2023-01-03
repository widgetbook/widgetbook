import 'package:widgetbook/src/navigation/helpers/widgetbook_use_case_helper.dart';
import 'package:widgetbook/src/repositories/story_repository.dart';
import 'package:widgetbook/src/state_change_notifier.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

class NavigationTreeProvider extends StateChangeNotifier<NavigationTreeState> {
  NavigationTreeProvider({
    required super.state,
    required this.storyRepository,
  });

  final StoryRepository storyRepository;

  void hotReload(List<MultiChildNavigationNodeData> nodes) {
    state = NavigationTreeState.unfiltered(nodes: nodes);
    final useCases = WidgetbookUseCaseHelper.fromNodes(nodes);
    storyRepository
      ..deleteAll()
      ..addAll(useCases);
  }

  void filter(String searchQuery) {
    final filteredNodes = filterNodes(searchQuery);

    state = state.copyWith(
      filteredNodes: filteredNodes,
    );
  }

  void resetFilter() {
    state = state.copyWith(
      filteredNodes: state.nodes,
    );
  }

  // Todo: use `FilterService` instead
  List<MultiChildNavigationNodeData> filterNodes(String searchQuery) {
    final nodes = state.nodes;
    final filteredNodes = <MultiChildNavigationNodeData>[];
    for (final node in nodes) {
      final matchedNode = node.filterNode(searchQuery);
      if (matchedNode != null) {
        filteredNodes.add(matchedNode);
      }
    }
    return filteredNodes;
  }
}
