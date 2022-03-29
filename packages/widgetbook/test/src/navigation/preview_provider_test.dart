import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/models/models.dart';
import 'package:widgetbook/src/navigation/preview_provider.dart';
import 'package:widgetbook/src/navigation/preview_state.dart';
import 'package:widgetbook/src/repositories/selected_story_repository.dart';
import 'package:widgetbook/src/repositories/story_repository.dart';

void main() {
  late StoryRepository storyRepository;
  late SelectedStoryRepository selectedStoryRepository;

  final story1 = WidgetbookUseCase(
    name: '1',
    builder: (context) => Container(),
  );

  final story2 = WidgetbookUseCase(
    name: '2',
    builder: (context) => Container(),
  );

  setUp(
    () {
      storyRepository = StoryRepository(
        initialConfiguration: <String, WidgetbookUseCase>{
          story1.name: story1,
          story2.name: story2,
        },
      );
      selectedStoryRepository = SelectedStoryRepository();
    },
  );

  group(
    '$PreviewProvider',
    () {
      test(
        'emits $WidgetbookUseCase when selectStory is called',
        () {
          final provider = PreviewProvider(
            storyRepository: storyRepository,
            selectedStoryRepository: selectedStoryRepository,
          )..selectUseCase(story1);

          expect(
            provider.state,
            equals(
              PreviewState(selectedUseCase: story1),
            ),
          );
        },
      );

      test(
        'emits ${PreviewState.unselected()} when deselectStory is called',
        () {
          final provider = PreviewProvider(
            state: PreviewState(selectedUseCase: story1),
            storyRepository: storyRepository,
            selectedStoryRepository: selectedStoryRepository,
          )..deselectStory();

          expect(
            provider.state,
            equals(
              PreviewState.unselected(),
            ),
          );
        },
      );

      test(
        'emits $WidgetbookUseCase when $SelectedStoryRepository emits new $WidgetbookUseCase',
        () async {
          final newStory = WidgetbookUseCase(
            name: story1.name,
            builder: (context) {
              return const Text('');
            },
          );

          final provider = PreviewProvider(
            state: PreviewState(selectedUseCase: story1),
            storyRepository: storyRepository,
            selectedStoryRepository: selectedStoryRepository,
          );

          storyRepository.setItem(newStory);
          // TODO improve this
          // without the `Future.delayed` the `expect` is called before the
          // provider had the chance to listen to the Stream's changes
          await Future<void>.delayed(const Duration(seconds: 1));

          expect(
            provider.state,
            equals(
              PreviewState(
                selectedUseCase: newStory,
              ),
            ),
          );
        },
      );

      test(
        'emits ${PreviewState.unselected()} when selected story gets deleted (on hot reload)',
        () async {
          final provider = PreviewProvider(
            state: PreviewState(selectedUseCase: story1),
            storyRepository: storyRepository,
            selectedStoryRepository: selectedStoryRepository,
          );

          storyRepository.deleteItem(story1);
          // TODO improve this
          // without the `Future.delayed` the `expect` is called before the
          // provider had the chance to listen to the Stream's changes
          await Future<void>.delayed(const Duration(seconds: 1));

          expect(
            provider.state,
            equals(
              PreviewState.unselected(),
            ),
          );
        },
      );
    },
  );
}
