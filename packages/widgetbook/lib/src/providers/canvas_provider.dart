import 'package:flutter/material.dart';
import 'package:widgetbook/src/models/organizers/story.dart';
import 'package:widgetbook/src/providers/canvas_state.dart';
import 'package:widgetbook/src/providers/provider.dart';
import 'package:widgetbook/src/repositories/selected_story_repository.dart';
import 'package:widgetbook/src/repositories/story_repository.dart';

class CanvasProvider extends Provider<CanvasState> {
  final StoryRepository storyRepository;
  final SelectedStoryRepository selectedStoryRepository;

  const CanvasProvider({
    required this.storyRepository,
    required this.selectedStoryRepository,
    required CanvasState state,
    required ValueChanged<CanvasState> onStateChanged,
    required Widget child,
    Key? key,
  }) : super(
          state: state,
          onStateChanged: onStateChanged,
          child: child,
          key: key,
        );

  static CanvasProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CanvasProvider>();
  }

  void initialize() {
    storyRepository.getStreamOfItems().forEach(
      (_) {
        _updateStory();
      },
    );
  }

  void _updateStory() {
    if (state.isStorySelected) {
      var currentStoryPath = state.selectedStory!.path;
      if (storyRepository.doesItemExist(currentStoryPath)) {
        var story = storyRepository.getItem(currentStoryPath);
        selectStory(story);
      }
    }
  }

  void selectStory(Story? story) {
    selectedStoryRepository.setItem(story);
    emit(
      CanvasState(
        selectedStory: story,
      ),
    );
  }

  void deselectStory() {
    selectedStoryRepository.deleteItem();
    emit(
      CanvasState.unselected(),
    );
  }
}
