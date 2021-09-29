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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CanvasState && other.selectedStory == selectedStory;
  }

  @override
  int get hashCode => selectedStory.hashCode;
}
