part of 'canvas_cubit.dart';

class CanvasState {
  final Story? selectedStory;

  CanvasState({
    required this.selectedStory,
  });

  factory CanvasState.unselected() {
    return CanvasState(selectedStory: null);
  }
}
