import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgetbook/src/multi_render_handle.dart';
import 'package:widgetbook/src/theming/theming.dart';
import 'package:widgetbook/src/theming/widgetbook_theme.dart';
import 'package:widgetbook/src/workbench/multi_render.dart';
import 'package:widgetbook/src/workbench/selection_item.dart';
import 'package:widgetbook/src/workbench/workbench.dart';

class ThemeHandle<CustomTheme> extends ConsumerWidget {
  const ThemeHandle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workbench = ref.read(getWorkbenchProvider<CustomTheme>().notifier);
    return MultiRenderHandle<WidgetbookTheme<CustomTheme>, CustomTheme>(
      multiRender: MultiRender.themes,
      items: ref.watch(getThemingProvider<CustomTheme>()).themes,
      buildItem: (WidgetbookTheme<CustomTheme> e) => SelectionItem(
        name: e.name,
        selectedItem: ref.watch(getWorkbenchProvider<CustomTheme>()).theme,
        item: e,
        onPressed: () {
          workbench.changedTheme(e);
        },
      ),
      onPreviousPressed: workbench.previousTheme,
      onNextPressed: workbench.nextTheme,
    );
  }
}
