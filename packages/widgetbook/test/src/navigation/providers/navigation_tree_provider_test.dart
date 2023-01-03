import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/navigation/navigation.dart';
import 'package:widgetbook/src/repositories/story_repository.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

void main() {
  late NavigationTreeProvider navigationTreeProvider;

  late StoryRepository storyRepository;

  final story1 = WidgetbookUseCase(
    name: 'Story 1',
    builder: (context) => Container(),
  );

  final story2 = WidgetbookUseCase(
    name: 'Story 2',
    builder: (context) => Container(),
  );

  final nodes = [
    WidgetbookPackage(
      name: 'Package',
      children: [
        WidgetbookCategory(name: 'Category', children: const []),
        WidgetbookComponent(
          name: 'Component',
          useCases: [
            WidgetbookUseCase(
              name: 'UseCase',
              builder: (context) => Container(),
            ),
          ],
        )
      ],
    ),
    WidgetbookComponent(
      name: 'Component',
      useCases: [
        WidgetbookUseCase(
          name: 'UseCase',
          builder: (context) => Container(),
        ),
      ],
    ),
  ];

  setUp(() {
    storyRepository = StoryRepository(
      initialConfiguration: <String, WidgetbookUseCase>{
        story1.name: story1,
        story2.name: story2,
      },
    );

    navigationTreeProvider = NavigationTreeProvider(
      state: NavigationTreeState(
        nodes: nodes,
      ),
      storyRepository: storyRepository,
    );
  });

  group('$NavigationTreeProvider', () {
    test(
      'Can filter navigation nodes',
      () {
        final testNodes = [
          WidgetbookPackage(name: 'Package', children: const []),
          WidgetbookComponent(
            name: 'Component',
            useCases: [
              WidgetbookUseCase(
                name: 'Use case',
                builder: (_) => Container(),
              ),
            ],
          ),
        ];
        navigationTreeProvider.state = navigationTreeProvider.state.copyWith(
          nodes: testNodes,
          filteredNodes: testNodes,
        );

        final results = [
          MultiChildNavigationNodeData(
            name: 'Component',
            type: NavigationNodeType.component,
            children: [
              WidgetbookUseCase(
                name: 'Use case',
                builder: (_) => Container(),
              ),
            ],
          ),
        ];

        navigationTreeProvider.filter('use case');
        expect(
          navigationTreeProvider.state.filteredNodes,
          equals(results),
        );
      },
      //Todo(Roaa94): make this test work
      // Currently it's not working because the `WidgetbookUseCase` builder
      // param equality doesn't work
      skip: true,
    );
  });
}
