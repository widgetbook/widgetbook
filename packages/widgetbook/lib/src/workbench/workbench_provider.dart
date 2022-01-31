import 'package:flutter/material.dart';
import 'package:widgetbook/src/extensions/list_extension.dart';
import 'package:widgetbook/src/state_change_notifier.dart';
import 'package:widgetbook/src/workbench/comparison_setting.dart';
import 'package:widgetbook/src/workbench/workbench_state.dart';
import 'package:widgetbook/widgetbook.dart';

class WorkbenchProvider<CustomTheme>
    extends StateChangeNotifier<WorkbenchState<CustomTheme>> {
  WorkbenchProvider({
    WorkbenchState<CustomTheme>? state,
    required this.locales,
    required this.themes,
    required this.devices,
    required this.deviceFrames,
  }) : super(
          state: state ??
              WorkbenchState(
                deviceFrame: deviceFrames.first,
                theme: themes.first,
                device: devices.first,
                locale: locales.first,
              ),
        );

  final List<Locale> locales;
  final List<WidgetbookTheme<CustomTheme>> themes;
  final List<Device> devices;
  final List<DeviceFrame> deviceFrames;

  void changedComparisonSetting(ComparisonSetting comparisonSetting) {
    if (state.comparisonSetting == comparisonSetting) {
      comparisonSetting = ComparisonSetting.none;
    }

    switch (comparisonSetting) {
      case ComparisonSetting.none:
        state = state.copyWith(
          comparisonSetting: comparisonSetting,
          locale: state.locale ?? locales.first,
          theme: state.theme ?? themes.first,
          device: state.device ?? devices.first,
        );
        break;
      case ComparisonSetting.themes:
        state = state.copyWith(
          comparisonSetting: comparisonSetting,
          locale: state.locale ?? locales.first,
          theme: null,
          device: state.device ?? devices.first,
        );
        break;
      case ComparisonSetting.devices:
        state = state.copyWith(
          comparisonSetting: comparisonSetting,
          locale: state.locale ?? locales.first,
          theme: state.theme ?? themes.first,
          device: null,
        );
        break;
      case ComparisonSetting.localization:
        state = state.copyWith(
          comparisonSetting: comparisonSetting,
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
      comparisonSetting: state.comparisonSetting == ComparisonSetting.devices
          ? ComparisonSetting.none
          : state.comparisonSetting,
    );
  }

  void changedTheme(WidgetbookTheme<CustomTheme>? widgetbookTheme) {
    state = state.copyWith(
      theme: widgetbookTheme,
      comparisonSetting: state.comparisonSetting == ComparisonSetting.themes
          ? ComparisonSetting.none
          : state.comparisonSetting,
    );
  }

  void changedLocale(Locale? locale) {
    state = state.copyWith(
      locale: locale,
      comparisonSetting:
          state.comparisonSetting == ComparisonSetting.localization
              ? ComparisonSetting.none
              : state.comparisonSetting,
    );
  }

  void changedDeviceFrame(DeviceFrame deviceFrame) {
    state = state.copyWith(deviceFrame: deviceFrame);
  }

  void nextLocale() {
    final nextLocale = locales.getNext(state.locale);
    state = state.copyWith(
      locale: nextLocale,
      comparisonSetting:
          state.comparisonSetting == ComparisonSetting.localization
              ? ComparisonSetting.none
              : state.comparisonSetting,
    );
  }

  void previousLocale() {
    final previousLocale = locales.getPrevious(state.locale);
    state = state.copyWith(
      locale: previousLocale,
      comparisonSetting:
          state.comparisonSetting == ComparisonSetting.localization
              ? ComparisonSetting.none
              : state.comparisonSetting,
    );
  }

  void nextTheme() {
    final nextTheme = themes.getNext(state.theme);
    state = state.copyWith(
      theme: nextTheme,
      comparisonSetting: state.comparisonSetting == ComparisonSetting.themes
          ? ComparisonSetting.none
          : state.comparisonSetting,
    );
  }

  void previousTheme() {
    final previousTheme = themes.getPrevious(state.theme);
    state = state.copyWith(
      theme: previousTheme,
      comparisonSetting: state.comparisonSetting == ComparisonSetting.themes
          ? ComparisonSetting.none
          : state.comparisonSetting,
    );
  }

  void nextDevice() {
    final nextDevice = devices.getNext(state.device);
    state = state.copyWith(
      device: nextDevice,
      comparisonSetting: state.comparisonSetting == ComparisonSetting.devices
          ? ComparisonSetting.none
          : state.comparisonSetting,
    );
  }

  void previousDevice() {
    final previousDevice = devices.getPrevious(state.device);
    state = state.copyWith(
      device: previousDevice,
      comparisonSetting: state.comparisonSetting == ComparisonSetting.devices
          ? ComparisonSetting.none
          : state.comparisonSetting,
    );
  }

  void nextDeviceFrame() {
    final nextDeviceFrame = deviceFrames.getNext(state.deviceFrame);
    state = state.copyWith(
      deviceFrame: nextDeviceFrame,
    );
  }

  void previousDeviceFrame() {
    final previousDevice = deviceFrames.getPrevious(state.deviceFrame);
    state = state.copyWith(
      deviceFrame: previousDevice,
    );
  }
}
