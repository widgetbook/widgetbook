import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/rendering/rendering_provider.dart';
import 'package:widgetbook/src/workbench/iteration_button.dart';
import 'package:widgetbook/src/workbench/selection_item.dart';
import 'package:widgetbook/src/workbench/workbench_provider.dart';
import 'package:widgetbook_models/widgetbook_models.dart';

class RenderHandle<CustomTheme> extends StatelessWidget {
  const RenderHandle({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final workbenchProvider = context.watch<WorkbenchProvider<CustomTheme>>();
    final workbenchState = workbenchProvider.state;

    final renderingState =
        context.watch<RenderingProvider<CustomTheme>>().state;

    return Row(
      children: [
        IterationButton.previous(
            onPressed: workbenchProvider.previousDeviceFrame),
        ...renderingState.frames
            .map(
              (e) => SelectionItem<WidgetbookFrame>(
                name: e.name,
                selectedItem: workbenchState.frame,
                item: e,
                onPressed: () {
                  workbenchProvider.changedDeviceFrame(e);
                },
              ),
            )
            .toList(),
        IterationButton.next(onPressed: workbenchProvider.nextDeviceFrame),
        const SizedBox(
          width: 8,
        ),
      ],
    );
  }
}
