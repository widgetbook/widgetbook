import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgetbook/src/devices/devices.dart';
import 'package:widgetbook/src/localization/localization.dart';
import 'package:widgetbook/src/theming/theming.dart';
import 'package:widgetbook/src/workbench/multi_render.dart';
import 'package:widgetbook/src/workbench/workbench_state.dart';
import 'package:widgetbook/widgetbook.dart';

final workbenchProvider =
    StateNotifierProvider<Workbench, WorkbenchState>((ref) {
  final localization = ref.watch(localizationProvider);
  final theming = ref.watch(themingProvider);
  final devices = ref.watch(devicesProvider);
  return Workbench(
      state: WorkbenchState(
        locale: localization.supportedLocales.first,
        theme: theming.themes.first,
        device: devices.devices.first,
      ),
      locales: localization.supportedLocales,
      themes: theming.themes,
      devices: devices.devices);
});

class Workbench extends StateNotifier<WorkbenchState> {
  Workbench({
    required WorkbenchState state,
    required this.locales,
    required this.themes,
    required this.devices,
  }) : super(state);

  final List<Locale> locales;
  final List<WidgetbookTheme> themes;
  final List<Device> devices;

  void changedMultiRender(MultiRender multiRender) {
    if (state.multiRender == multiRender) {
      multiRender = MultiRender.none;
    }

    switch (multiRender) {
      case MultiRender.none:
        state = state.copyWith(
          multiRender: multiRender,
          locale: state.locale ?? locales.first,
          theme: state.theme ?? themes.first,
          device: state.device ?? devices.first,
        );
        break;
      case MultiRender.themes:
        state = state.copyWith(
          multiRender: multiRender,
          locale: state.locale ?? locales.first,
          theme: null,
          device: state.device ?? devices.first,
        );
        break;
      case MultiRender.devices:
        state = state.copyWith(
          multiRender: multiRender,
          locale: state.locale ?? locales.first,
          theme: state.theme ?? themes.first,
          device: null,
        );
        break;
      case MultiRender.localization:
        state = state.copyWith(
          multiRender: multiRender,
          locale: null,
          theme: state.theme ?? themes.first,
          device: state.device ?? devices.first,
        );
        break;
    }
  }

  void changedDevice(Device? device) {
    state = state.copyWith(
      device: device,
      multiRender: state.multiRender == MultiRender.devices
          ? MultiRender.none
          : state.multiRender,
    );
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

  void nextDevice() {
    final nextDevice = _getNext(state.device, devices);
    state = state.copyWith(
      device: nextDevice,
      multiRender: state.multiRender == MultiRender.devices
          ? MultiRender.none
          : state.multiRender,
    );
  }

  void previousDevice() {
    final previousDevice = _getPrevious(state.device, devices);
    state = state.copyWith(
      device: previousDevice,
      multiRender: state.multiRender == MultiRender.devices
          ? MultiRender.none
          : state.multiRender,
    );
  }
}
