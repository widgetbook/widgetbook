import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgetbook/src/multi_render_handle.dart';
import 'package:widgetbook/src/theming/theming.dart';
import 'package:widgetbook/src/theming/widgetbook_theme.dart';
import 'package:widgetbook/src/workbench/multi_render.dart';
import 'package:widgetbook/src/workbench/selection_item.dart';
import 'package:widgetbook/src/workbench/workbench.dart';

class ThemeHandle extends ConsumerWidget {
  const ThemeHandle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workbench = ref.read(workbenchProvider.notifier);
    return MultiRenderHandle<WidgetbookTheme>(
      multiRender: MultiRender.themes,
      items: ref.read(themingProvider).themes,
      buildItem: (WidgetbookTheme e) => SelectionItem(
        iconData: e.icon,
        tooltip: e.name,
        selectedItem: ref.watch(workbenchProvider).theme,
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
