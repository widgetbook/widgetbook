import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgetbook/src/localization/localization.dart';
import 'package:widgetbook/src/multi_render_handle.dart';
import 'package:widgetbook/src/workbench/multi_render.dart';
import 'package:widgetbook/src/workbench/selection_item.dart';
import 'package:widgetbook/src/workbench/workbench_provider.dart';

class LocalizationHandle<CustomTheme> extends ConsumerWidget {
  const LocalizationHandle({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workbench = ref.read(getWorkbenchProvider<CustomTheme>().notifier);
    return MultiRenderHandle<Locale, CustomTheme>(
      multiRender: MultiRender.localization,
      items: ref.read(localizationProvider).supportedLocales,
      buildItem: (Locale e) => SelectionItem(
        name: e.toLanguageTag(),
        selectedItem: ref.watch(getWorkbenchProvider<CustomTheme>()).locale,
        item: e,
        onPressed: () {
          workbench.changedLocale(e);
        },
      ),
      onPreviousPressed: workbench.previousLocale,
      onNextPressed: workbench.nextLocale,
    );
  }
}
