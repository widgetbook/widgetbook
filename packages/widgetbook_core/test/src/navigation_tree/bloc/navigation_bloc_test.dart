import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

void main() {
  group('$NavigationBloc', () {
    const packageDirectory = MultiChildNavigationNodeData(
      name: 'Package',
      type: NavigationNodeType.package,
      children: [
        MultiChildNavigationNodeData(
          name: 'Component',
          type: NavigationNodeType.component,
          children: [
            LeafNavigationNodeData(
              name: 'Use Case 1',
              type: NavigationNodeType.useCase,
            ),
          ],
        )
      ],
    );
    const categoryDirectory = MultiChildNavigationNodeData(
      name: 'Category',
      type: NavigationNodeType.category,
      children: [
        MultiChildNavigationNodeData(
          name: 'Component',
          type: NavigationNodeType.component,
          children: [
            LeafNavigationNodeData(
              name: 'Use Case 2',
              type: NavigationNodeType.useCase,
            ),
            LeafNavigationNodeData(
              name: 'Use Case 3',
              type: NavigationNodeType.useCase,
            ),
          ],
        ),
      ],
    );
    const directories = [
      packageDirectory,
      categoryDirectory,
    ];

    const packageNode = NavigationTreeNodeData(
      path: 'package',
      name: 'Package',
      type: NavigationNodeType.package,
      children: [
        NavigationTreeNodeData(
          path: 'package/component',
          name: 'Component',
          type: NavigationNodeType.component,
          children: [
            NavigationTreeNodeData(
              path: 'package/component/use-case-1',
              name: 'Use Case 1',
              type: NavigationNodeType.useCase,
            ),
          ],
        ),
      ],
    );
    const categoryNode = NavigationTreeNodeData(
      path: 'category',
      name: 'Category',
      type: NavigationNodeType.category,
      children: [
        NavigationTreeNodeData(
          path: 'category/component',
          name: 'Component',
          type: NavigationNodeType.component,
          children: [
            NavigationTreeNodeData(
              path: 'category/component/use-case-2',
              name: 'Use Case 2',
              type: NavigationNodeType.useCase,
            ),
            NavigationTreeNodeData(
              path: 'category/component/use-case-3',
              name: 'Use Case 3',
              type: NavigationNodeType.useCase,
            ),
          ],
        ),
      ],
    );

    const nodes = [
      packageNode,
      categoryNode,
    ];

    const selectedNode = NavigationTreeNodeData(
      path: 'package/component/use-case-1',
      name: 'Use Case 1',
      type: NavigationNodeType.useCase,
    );

    const filteredNodesByUseCase3 = [
      NavigationTreeNodeData(
        path: 'category',
        name: 'Category',
        type: NavigationNodeType.category,
        children: [
          NavigationTreeNodeData(
            path: 'category/component',
            name: 'Component',
            type: NavigationNodeType.component,
            children: [
              NavigationTreeNodeData(
                path: 'category/component/use-case-3',
                name: 'Use Case 3',
                type: NavigationNodeType.useCase,
              ),
            ],
          ),
        ],
      ),
    ];

    blocTest<NavigationBloc, NavigationState>(
      'Emits state with correct nodes when $LoadNavigationTree event is added',
      build: NavigationBloc.new,
      act: (bloc) => bloc.add(
        const LoadNavigationTree(directories: directories),
      ),
      expect: () => <NavigationState>[
        NavigationState(
          nodes: nodes,
          filteredNodes: nodes,
        ),
      ],
    );

    blocTest<NavigationBloc, NavigationState>(
      'Emits state with filtered nodes when $LoadNavigationTree event is added '
      'on an existing query',
      build: NavigationBloc.new,
      act: (bloc) => bloc.add(
        const LoadNavigationTree(directories: directories),
      ),
      seed: () => NavigationState(searchQuery: 'package'),
      expect: () => <NavigationState>[
        NavigationState(
          searchQuery: 'package',
          nodes: nodes,
          filteredNodes: [packageNode],
        ),
      ],
    );

    blocTest<NavigationBloc, NavigationState>(
      'Updates selected node when $SelectNavigationNode event is added',
      build: NavigationBloc.new,
      seed: () => NavigationState(
        nodes: nodes,
        filteredNodes: nodes,
      ),
      act: (bloc) => bloc.add(
        const SelectNavigationNode(node: selectedNode),
      ),
      expect: () => <NavigationState>[
        NavigationState(
          nodes: nodes,
          filteredNodes: nodes,
          selectedNode: selectedNode,
        ),
      ],
    );

    blocTest<NavigationBloc, NavigationState>(
      'Updates selected node when $SelectNavigationNodeByPath event is added',
      build: NavigationBloc.new,
      seed: () => NavigationState(
        nodes: nodes,
        filteredNodes: nodes,
      ),
      act: (bloc) => bloc.add(
        const SelectNavigationNodeByPath(
          path: '/?path=package/component/use-case-1',
        ),
      ),
      expect: () => <NavigationState>[
        NavigationState(
          nodes: nodes,
          filteredNodes: nodes,
          selectedNode: selectedNode,
        ),
      ],
    );

    blocTest<NavigationBloc, NavigationState>(
      'Emits filtered nodes when $FilterNavigationNodes event is added',
      build: NavigationBloc.new,
      seed: () => NavigationState(
        nodes: nodes,
        filteredNodes: nodes,
      ),
      act: (bloc) => bloc.add(
        const FilterNavigationNodes(searchQuery: 'use case 3'),
      ),
      expect: () => <NavigationState>[
        NavigationState(
          nodes: nodes,
          filteredNodes: filteredNodesByUseCase3,
          searchQuery: 'use case 3',
        ),
      ],
    );

    blocTest<NavigationBloc, NavigationState>(
      'Resets filtered nodes when $ResetNodesFilter event is added',
      build: NavigationBloc.new,
      seed: () => NavigationState(
        nodes: nodes,
        filteredNodes: filteredNodesByUseCase3,
        searchQuery: 'search-query',
      ),
      act: (bloc) => bloc.add(
        const ResetNodesFilter(),
      ),
      expect: () => <NavigationState>[
        NavigationState(
          nodes: nodes,
          filteredNodes: nodes,
        ),
      ],
    );
  });
}
