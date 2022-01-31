import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/rendering/device_frame.dart';
import 'package:widgetbook/src/rendering/rendering_provider.dart';
import 'package:widgetbook/src/workbench/iteration_button.dart';
import 'package:widgetbook/src/workbench/selection_item.dart';
import 'package:widgetbook/src/workbench/workbench_provider.dart';

class RenderHandle<CustomTheme> extends ConsumerWidget {
  const RenderHandle({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workbenchProvider = context.watch<WorkbenchProvider<CustomTheme>>();
    final workbenchState = workbenchProvider.state;

    final renderingState =
        context.watch<RenderingProvider<CustomTheme>>().state;

    return Row(
      children: [
        IterationButton.left(onPressed: workbenchProvider.previousDeviceFrame),
        ...renderingState.deviceFrames
            .map(
              (e) => SelectionItem<DeviceFrame>(
                name: e.name,
                selectedItem: workbenchState.deviceFrame,
                item: e,
                onPressed: () {
                  workbenchProvider.changedDeviceFrame(e);
                },
              ),
            )
            .toList(),
        IterationButton.right(onPressed: workbenchProvider.nextDeviceFrame),
        const SizedBox(
          width: 8,
        ),
      ],
    );
  }
}
