import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/models/organizers/organizers.dart';
import 'package:widgetbook/src/providers/canvas_provider.dart';
import 'package:widgetbook/src/widgets/device_render.dart';
import 'package:widgetbook/src/widgets/multi_device_renderer.dart';
import 'package:widgetbook/src/workbench/multi_render.dart';
import 'package:widgetbook/src/workbench/workbench_provider.dart';
import 'package:widgetbook/src/zoom/zoom_provider.dart';

class UseCaseRender<CustomTheme> extends ConsumerWidget {
  const UseCaseRender({Key? key}) : super(key: key);

  Widget _buildCanvas(
    BuildContext context,
    WidgetbookUseCase story,
    WidgetRef ref,
  ) {
    final workkbenchState =
        context.watch<WorkbenchProvider<CustomTheme>>().state;

    return workkbenchState.multiRender == MultiRender.none
        ? ClipRect(
            child: OverflowBox(
              child: Transform.scale(
                scale: context.watch<ZoomProvider>().state.zoomLevel,
                child: DeviceRender<CustomTheme>(
                  story: story,
                ),
              ),
            ),
          )
        : SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: MultiRenderer<CustomTheme>(),
          );
  }

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final state = CanvasProvider.of(context)!.state;
    if (state.selectedStory != null) {
      return _buildCanvas(context, state.selectedStory!, ref);
    }

    return Center(
      child: Container(),
    );
  }
}
