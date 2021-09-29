import 'package:widgetbook/src/models/organizers/story.dart';

class CanvasState {
  final Story? selectedStory;
  bool get isStorySelected => selectedStory != null;

  CanvasState({
    required this.selectedStory,
  });

  factory CanvasState.unselected() {
    return CanvasState(selectedStory: null);
  }
}
