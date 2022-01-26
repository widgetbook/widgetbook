import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgetbook/src/localization/localization_provider.dart';
import 'package:widgetbook/src/theming/widgetbook_theme.dart';
import 'package:widgetbook/src/workbench/multi_render.dart';
import 'package:widgetbook/src/workbench/workbench_state.dart';

final workbenchProvider =
    StateNotifierProvider<Workbench, WorkbenchState>((ref) {
  final localization = ref.read(localizationProvider);
  return Workbench(
    state: WorkbenchState(
      locale: localization.supportedLocales.first,
    ),
    locales: localization.supportedLocales,
  );
});

class Workbench extends StateNotifier<WorkbenchState> {
  Workbench({
    WorkbenchState? state,
    required this.locales,
  }) : super(state ?? WorkbenchState());

  final List<Locale> locales;

  void changedMultiRender(MultiRender multiRender) {
    if (state.multiRender == multiRender) {
      multiRender = MultiRender.none;
    }

    switch (multiRender) {
      case MultiRender.none:
        state = state.copyWith(
          multiRender: multiRender,
          locale: locales.first,
        );
        break;
      case MultiRender.themes:
        state = state.copyWith(
          multiRender: multiRender,
          theme: null,
        );
        break;
      case MultiRender.devices:
        // TODO: Handle this case.
        break;
      case MultiRender.localization:
        state = state.copyWith(
          multiRender: multiRender,
          locale: null,
        );
        break;
    }
  }

  void changedTheme(WidgetbookTheme? widgetbookTheme) {
    state = state.copyWith(theme: widgetbookTheme);
  }

  void changedLocale(Locale? locale) {
    state = state.copyWith(locale: locale);
  }

  // TODO this can be an extension method on [List]
  T _getNext<T>(T? currentItem, List<T> items) {
    final selectedItem = currentItem ?? items.last;
    final index = items.indexOf(selectedItem);
    final nextIndex = (index + 1) % locales.length;
    return items[nextIndex];
  }

  // TODO this can be an extension method on [List]
  T _getPrevious<T>(T? currentItem, List<T> items) {
    final selectedItem = currentItem ?? items.last;
    final index = items.indexOf(selectedItem);
    var previousIndex = index - 1;
    if (previousIndex < 0) {
      previousIndex = locales.length - 1;
    }
    return items[previousIndex];
  }

  void nextLocale() {
    final nextLocale = _getNext(state.locale, locales);
    state = state.copyWith(
      locale: nextLocale,
      multiRender: state.multiRender == MultiRender.localization
          ? MultiRender.none
          : state.multiRender,
    );
  }

  void previousLocale() {
    final previousLocale = _getPrevious(state.locale, locales);
    state = state.copyWith(
      locale: previousLocale,
      multiRender: state.multiRender == MultiRender.localization
          ? MultiRender.none
          : state.multiRender,
    );
  }
}
