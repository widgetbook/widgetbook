import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/workbench/selection_item.dart';
import 'package:widgetbook/src/workbench/workbench_provider.dart';

class OrientationHandle<CustomTheme> extends StatelessWidget {
  const OrientationHandle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final workbenchProvider = context.watch<WorkbenchProvider<CustomTheme>>();
    final workbenchState = workbenchProvider.state;
    return SelectionItem(
      name: 'Portrait',
      selectedItem: workbenchState.orientation,
      item: Orientation.portrait,
      onPressed: workbenchProvider.toggledOrientation,
    );
  }
}
