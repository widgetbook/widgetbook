import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/models/organizers/story.dart';
import 'package:widgetbook/src/providers/canvas_provider.dart';
import 'package:widgetbook/src/providers/canvas_state.dart';
import 'package:widgetbook/src/repositories/selected_story_repository.dart';
import 'package:widgetbook/src/repositories/story_repository.dart';

import '../../helper/provider_helper.dart';
import '../../helper/widget_test_helper.dart';

extension _WidgetTesterProviderExtension on WidgetTester {
  Future<CanvasProvider> pumpProvider({
    required StoryRepository storyRepository,
    required SelectedStoryRepository selectedStoryRepository,
  }) async {
    final provider = await pumpBuilderAndReturnProvider<CanvasProvider>(
      CanvasBuilder(
        storyRepository: storyRepository,
        selectedStoryRepository: selectedStoryRepository,
        child: Container(),
      ),
    );
    return provider;
  }
}

void main() {
  late StoryRepository storyRepository;
  late SelectedStoryRepository selectedStoryRepository;

  final story1 = Story(
    name: '1',
    builder: (context) => Container(),
  );

  final story2 = Story(
    name: '2',
    builder: (context) => Container(),
  );

  setUp(
    () {
      storyRepository = StoryRepository(
        initialConfiguration: <String, Story>{
          story1.name: story1,
          story2.name: story2,
        },
      );
      selectedStoryRepository = SelectedStoryRepository();
    },
  );

  group(
    '$CanvasProvider',
    () {
      testWidgets(
        'emits $Story when selectStory is called',
        (WidgetTester tester) async {
          var provider = await tester.pumpProvider(
            selectedStoryRepository: selectedStoryRepository,
            storyRepository: storyRepository,
          );

          provider = await tester.invokeMethodAndReturnPumpedProvider(
            () {
              provider.selectStory(story1);
            },
          );

          expect(
            provider.state,
            equals(
              CanvasState(selectedStory: story1),
            ),
          );
        },
      );

      testWidgets(
        'emits null when deselectStory is called',
        (WidgetTester tester) async {
          var provider = await tester.pumpProvider(
            selectedStoryRepository: selectedStoryRepository,
            storyRepository: storyRepository,
          );

          // TODO would be better to inject the state instead of calling
          // selectStory
          provider = await tester.invokeMethodAndReturnPumpedProvider(
            () {
              provider.selectStory(story1);
            },
          );

          provider = await tester.invokeMethodAndReturnPumpedProvider(
            () {
              provider.deselectStory();
            },
          );

          expect(
            provider.state,
            equals(
              CanvasState.unselected(),
            ),
          );
        },
      );

      testWidgets(
        'emits $Story $SelectedStoryRepository emits new $Story',
        (WidgetTester tester) async {
          var provider = await tester.pumpProvider(
            selectedStoryRepository: selectedStoryRepository,
            storyRepository: storyRepository,
          );

          provider = await tester.invokeMethodAndReturnPumpedProvider(
            () {
              provider.selectStory(story1);
            },
          );

          final newStory = Story(
            name: story1.name,
            builder: (context) {
              return const Text('');
            },
          );

          provider = await tester.invokeMethodAndReturnPumpedProvider(
            () {
              storyRepository.setItem(newStory);
            },
          );

          expect(
            provider.state,
            equals(
              CanvasState(
                selectedStory: newStory,
              ),
            ),
          );
        },
      );

      testWidgets(
        'emits $Story $SelectedStoryRepository emits new $Story',
        (WidgetTester tester) async {
          var provider = await tester.pumpProvider(
            selectedStoryRepository: selectedStoryRepository,
            storyRepository: storyRepository,
          );

          provider = await tester.invokeMethodAndReturnPumpedProvider(
            () {
              provider.selectStory(story1);
            },
          );

          provider = await tester.invokeMethodAndReturnPumpedProvider(
            () {
              storyRepository.deleteItem(story1);
            },
          );

          expect(
            provider.state,
            equals(
              CanvasState.unselected(),
            ),
          );
        },
      );

      testWidgets(
        '.of returns $CanvasProvider instance',
        (WidgetTester tester) async {
          await tester.pumpWidgetWithMaterialApp(
            CanvasBuilder(
              selectedStoryRepository: selectedStoryRepository,
              storyRepository: storyRepository,
              child: Container(),
            ),
          );

          final BuildContext context = tester.element(find.byType(Container));
          final provider = CanvasProvider.of(context);
          expect(
            provider,
            isNot(null),
          );
        },
      );
    },
  );
}
