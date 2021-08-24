import 'package:bloc/bloc.dart';
import 'package:widgetbook/models/organizers/story.dart';
import 'package:meta/meta.dart';

part 'canvas_state.dart';

class CanvasCubit extends Cubit<CanvasState> {
  CanvasCubit()
      : super(
          CanvasState.unselected(),
        );

  void selectStory(Story? story) {
    emit(
      CanvasState(
        selectedStory: story,
      ),
    );
  }
}
