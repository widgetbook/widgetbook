import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgetbook/src/localization/localization_provider.dart';
import 'package:widgetbook/src/theming/theming.dart';
import 'package:widgetbook/src/theming/widgetbook_theme.dart';
import 'package:widgetbook/src/workbench/multi_render.dart';
import 'package:widgetbook/src/workbench/workbench_state.dart';

final workbenchProvider =
    StateNotifierProvider<Workbench, WorkbenchState>((ref) {
  final localization = ref.watch(localizationProvider);
  final theming = ref.watch(themingProvider);
  return Workbench(
    state: WorkbenchState(
      locale: localization.supportedLocales.first,
      theme: theming.themes.first,
    ),
    locales: localization.supportedLocales,
    themes: theming.themes,
  );
});

class Workbench extends StateNotifier<WorkbenchState> {
  Workbench({
    required WorkbenchState state,
    required this.locales,
    required this.themes,
  }) : super(state);

  final List<Locale> locales;
  final List<WidgetbookTheme> themes;

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
    state = state.copyWith(
      theme: widgetbookTheme,
      multiRender: state.multiRender == MultiRender.themes
          ? MultiRender.none
          : state.multiRender,
    );
  }

  void changedLocale(Locale? locale) {
    state = state.copyWith(
      locale: locale,
      multiRender: state.multiRender == MultiRender.localization
          ? MultiRender.none
          : state.multiRender,
    );
  }

  // TODO this can be an extension method on [List]
  T _getNext<T>(T? currentItem, List<T> items) {
    final selectedItem = currentItem ?? items.last;
    final index = items.indexOf(selectedItem);
    final nextIndex = (index + 1) % items.length;
    return items[nextIndex];
  }

  // TODO this can be an extension method on [List]
  T _getPrevious<T>(T? currentItem, List<T> items) {
    final selectedItem = currentItem ?? items.last;
    final index = items.indexOf(selectedItem);
    var previousIndex = index - 1;
    if (previousIndex < 0) {
      previousIndex = items.length - 1;
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

  void nextTheme() {
    final nextTheme = _getNext(state.theme, themes);
    state = state.copyWith(
      theme: nextTheme,
      multiRender: state.multiRender == MultiRender.themes
          ? MultiRender.none
          : state.multiRender,
    );
  }

  void previousTheme() {
    final previousTheme = _getPrevious(state.theme, themes);
    state = state.copyWith(
      theme: previousTheme,
      multiRender: state.multiRender == MultiRender.themes
          ? MultiRender.none
          : state.multiRender,
    );
  }
}
