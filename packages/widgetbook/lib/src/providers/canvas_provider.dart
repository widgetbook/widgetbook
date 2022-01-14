import 'package:flutter/material.dart';
import 'package:widgetbook/src/models/organizers/widgetbook_use_case.dart';
import 'package:widgetbook/src/providers/canvas_state.dart';
import 'package:widgetbook/src/providers/provider.dart';
import 'package:widgetbook/src/repositories/selected_story_repository.dart';
import 'package:widgetbook/src/repositories/story_repository.dart';

class CanvasBuilder extends StatefulWidget {
  const CanvasBuilder({
    Key? key,
    required this.child,
    required this.storyRepository,
    required this.selectedStoryRepository,
  }) : super(key: key);

  final Widget child;
  final StoryRepository storyRepository;
  final SelectedStoryRepository selectedStoryRepository;

  @override
  _CanvasBuilderState createState() => _CanvasBuilderState();
}

class _CanvasBuilderState extends State<CanvasBuilder> {
  CanvasState state = CanvasState.unselected();
  late CanvasProvider provider;

  void setProvider() {
    provider = CanvasProvider(
      storyRepository: widget.storyRepository,
      selectedStoryRepository: widget.selectedStoryRepository,
      state: state,
      onStateChanged: (CanvasState state) {
        setState(() {
          this.state = state;
          setProvider();
        });
      },
      child: widget.child,
    );
  }

  @override
  void initState() {
    setProvider();
    widget.storyRepository.getStreamOfItems().forEach((_) {
      provider.updateStory();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return provider;
  }
}

class CanvasProvider extends Provider<CanvasState> {
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

  final StoryRepository storyRepository;
  final SelectedStoryRepository selectedStoryRepository;

  static CanvasProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CanvasProvider>();
  }

  void updateStory() {
    if (state.isStorySelected) {
      final currentStoryPath = state.selectedStory!.path;
      if (storyRepository.doesItemExist(currentStoryPath)) {
        final story = storyRepository.getItem(currentStoryPath);
        selectStory(story);
      } else {
        deselectStory();
      }
    }
  }

  Future<void> selectStory(WidgetbookUseCase? story) async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
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
