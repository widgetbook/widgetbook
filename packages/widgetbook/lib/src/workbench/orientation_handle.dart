import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/extensions/enum_extension.dart';
import 'package:widgetbook/src/workbench/selection_handle.dart';
import 'package:widgetbook/src/workbench/selection_item.dart';
import 'package:widgetbook/src/workbench/workbench_provider.dart';

class OrientationHandle<CustomTheme> extends StatelessWidget {
  const OrientationHandle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final workbenchProvider = context.watch<WorkbenchProvider<CustomTheme>>();
    final workbenchState = workbenchProvider.state;
    return SelectionHandle<Orientation, CustomTheme>(
      name: 'Orientation',
      items: const [
        Orientation.portrait,
        Orientation.landscape,
      ],
      buildItem: (e) => SelectionItem<Orientation>(
        name: e.name,
        selectedItem: workbenchState.orientation,
        item: e,
        onPressed: () {
          workbenchProvider.setOrientationByName(e.toShortString());
        },
      ),
      onPreviousPressed: workbenchProvider.toggledOrientation,
      onNextPressed: workbenchProvider.toggledOrientation,
    );
  }
}
