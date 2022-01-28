import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgetbook/src/models/organizers/organizers.dart';
import 'package:widgetbook/src/providers/canvas_provider.dart';
import 'package:widgetbook/src/widgets/device_render.dart';
import 'package:widgetbook/src/widgets/multi_device_renderer.dart';
import 'package:widgetbook/src/workbench/multi_render.dart';
import 'package:widgetbook/src/workbench/workbench.dart';

class UseCaseRender<CustomTheme> extends ConsumerStatefulWidget {
  const UseCaseRender({Key? key}) : super(key: key);

  @override
  _StoryState createState() => _StoryState<CustomTheme>();
}

class _StoryState<CustomTheme> extends ConsumerState<UseCaseRender> {
  Widget _buildStory() {
    final state = CanvasProvider.of(context)!.state;
    if (state.selectedStory != null) {
      return _buildCanvas(state.selectedStory!);
    }

    return Center(
      child: Container(),
    );
  }

  Widget _buildCanvas(WidgetbookUseCase story) {
    final workkbenchState = ref.watch(getWorkbenchProvider<CustomTheme>());

    return workkbenchState.multiRender == MultiRender.none
        ? DeviceRender<CustomTheme>(
            story: story,
          )
        : SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: MultiRenderer<CustomTheme>(),
          );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return _buildStory();
  }
}
