import 'package:bloc/bloc.dart';
import 'package:widgetbook/src/models/organizers/story.dart';
import 'package:widgetbook/src/repository/story_repository.dart';

part 'canvas_state.dart';

class CanvasCubit extends Cubit<CanvasState> {
  final StoryRepository storyRepository;
  CanvasCubit({
    required this.storyRepository,
  }) : super(
          CanvasState.unselected(),
        ) {
    storyRepository.getStreamOfItems().forEach(
      (_) {
        print('$CanvasState received notification');
        for (var item in _) {
          print(item.path);
        }
        if (state.isStorySelected) {
          var currentStoryPath = state.selectedStory!.path;
          if (storyRepository.doesItemExist(currentStoryPath)) {
            print('Looking up new story');
            emit(
              CanvasState(
                selectedStory: storyRepository.getItem(currentStoryPath),
              ),
            );
          }
        }
      },
    );
  }

  void selectStory(Story? story) {
    emit(
      CanvasState(
        selectedStory: story,
      ),
    );
  }
}
