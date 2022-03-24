import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/workbench/selection_handle.dart';
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

    return SelectionHandle<WidgetbookFrame, CustomTheme>(
      name: 'Frames',
      items: workbenchState.frames,
      buildItem: (e) => SelectionItem<WidgetbookFrame>(
        name: e.name,
        selectedItem: workbenchState.frame,
        item: e,
        onPressed: () {
          workbenchProvider.changedDeviceFrame(e);
        },
      ),
      onPreviousPressed: workbenchProvider.previousDeviceFrame,
      onNextPressed: workbenchProvider.nextDeviceFrame,
    );
  }
}
