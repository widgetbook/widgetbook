import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/theming/widgetbook_theme.dart';
import 'package:widgetbook/src/workbench/comparison_handle.dart';
import 'package:widgetbook/src/workbench/comparison_setting.dart';
import 'package:widgetbook/src/workbench/selection_item.dart';
import 'package:widgetbook/src/workbench/workbench_provider.dart';

class ThemeHandle<CustomTheme> extends StatelessWidget {
  const ThemeHandle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final workbenchProvider = context.watch<WorkbenchProvider<CustomTheme>>();
    final workbenchState = workbenchProvider.state;

    return ComparisonHandle<WidgetbookTheme<CustomTheme>, CustomTheme>(
      name: 'Themes',
      multiRender: ComparisonSetting.themes,
      items: workbenchState.themes,
      buildItem: (WidgetbookTheme<CustomTheme> e) => SelectionItem(
        name: e.name,
        selectedItem: workbenchState.theme,
        item: e,
        onPressed: () {
          workbenchProvider.changedTheme(e);
        },
      ),
      onPreviousPressed: workbenchProvider.previousTheme,
      onNextPressed: workbenchProvider.nextTheme,
    );
  }
}
