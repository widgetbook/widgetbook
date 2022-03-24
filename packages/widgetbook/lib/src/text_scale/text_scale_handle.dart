import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/workbench/comparison_handle.dart';
import 'package:widgetbook/src/workbench/comparison_setting.dart';
import 'package:widgetbook/src/workbench/selection_item.dart';
import 'package:widgetbook/src/workbench/workbench_provider.dart';

class TextScaleHandle<CustomTheme> extends StatelessWidget {
  const TextScaleHandle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final workbenchProvider = context.watch<WorkbenchProvider<CustomTheme>>();
    final workbenchState = workbenchProvider.state;
    return ComparisonHandle<double, CustomTheme>(
      name: 'Text scale factors',
      multiRender: ComparisonSetting.textScale,
      items: workbenchState.textScaleFactors,
      buildItem: (double e) => SelectionItem(
        name: e.toStringAsFixed(2),
        selectedItem: workbenchState.textScaleFactor,
        item: e,
        onPressed: () {
          workbenchProvider.changedTextScaleFactor(e);
        },
      ),
      onPreviousPressed: workbenchProvider.previousTextScaleFactor,
      onNextPressed: workbenchProvider.nextTextScaleFactor,
    );
  }
}
