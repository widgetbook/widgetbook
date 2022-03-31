import 'package:widgetbook/src/models/models.dart';
import 'package:widgetbook/src/navigation/preview_state.dart';
import 'package:widgetbook/src/repositories/selected_story_repository.dart';
import 'package:widgetbook/src/repositories/story_repository.dart';
import 'package:widgetbook/src/state_change_notifier.dart';

class PreviewProvider extends StateChangeNotifier<PreviewState> {
  PreviewProvider({
    PreviewState? state,
    required this.storyRepository,
    required this.selectedStoryRepository,
  }) : super(
          state: state ?? PreviewState.unselected(),
        ) {
    storyRepository.getStreamOfItems().forEach((_) {
      updateStory();
    });
  }

  final StoryRepository storyRepository;
  final SelectedStoryRepository selectedStoryRepository;

  void updateStory() {
    if (state.isUseCaseSelected) {
      final currentStoryPath = state.selectedUseCase!.path;
      if (storyRepository.doesItemExist(currentStoryPath)) {
        final story = storyRepository.getItem(currentStoryPath);
        selectUseCase(story);
      } else {
        deselectStory();
      }
    }
  }

  void selectUseCase(WidgetbookUseCase? story) {
    selectedStoryRepository.setItem(story);
    state = PreviewState(
      selectedUseCase: story,
    );
  }

  void selectUseCaseByPath(String? path) {
    if (path == null) {
      return;
    }

    state = PreviewState(selectedUseCase: storyRepository.memory[path]);
  }

  void deselectStory() {
    selectedStoryRepository.deleteItem();
    state = PreviewState.unselected();
  }
}
