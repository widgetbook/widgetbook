part of 'canvas_cubit.dart';

@immutable
class CanvasState {
  final Story? selectedStory;

  CanvasState({
    required this.selectedStory,
  });

  factory CanvasState.unselected() {
    return CanvasState(selectedStory: null);
  }
}
