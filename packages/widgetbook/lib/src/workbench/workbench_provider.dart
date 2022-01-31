import 'package:flutter/material.dart';
import 'package:widgetbook/src/extensions/list_extension.dart';
import 'package:widgetbook/src/rendering/device_frame.dart';
import 'package:widgetbook/src/state_change_notifier.dart';
import 'package:widgetbook/src/workbench/multi_render.dart';
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

  void changedTheme(WidgetbookTheme<CustomTheme>? widgetbookTheme) {
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

  void changedDeviceFrame(DeviceFrame deviceFrame) {
    state = state.copyWith(deviceFrame: deviceFrame);
  }

  void nextLocale() {
    final nextLocale = locales.getNext(state.locale);
    state = state.copyWith(
      locale: nextLocale,
      multiRender: state.multiRender == MultiRender.localization
          ? MultiRender.none
          : state.multiRender,
    );
  }

  void previousLocale() {
    final previousLocale = locales.getPrevious(state.locale);
    state = state.copyWith(
      locale: previousLocale,
      multiRender: state.multiRender == MultiRender.localization
          ? MultiRender.none
          : state.multiRender,
    );
  }

  void nextTheme() {
    final nextTheme = themes.getNext(state.theme);
    state = state.copyWith(
      theme: nextTheme,
      multiRender: state.multiRender == MultiRender.themes
          ? MultiRender.none
          : state.multiRender,
    );
  }

  void previousTheme() {
    final previousTheme = themes.getPrevious(state.theme);
    state = state.copyWith(
      theme: previousTheme,
      multiRender: state.multiRender == MultiRender.themes
          ? MultiRender.none
          : state.multiRender,
    );
  }

  void nextDevice() {
    final nextDevice = devices.getNext(state.device);
    state = state.copyWith(
      device: nextDevice,
      multiRender: state.multiRender == MultiRender.devices
          ? MultiRender.none
          : state.multiRender,
    );
  }

  void previousDevice() {
    final previousDevice = devices.getPrevious(state.device);
    state = state.copyWith(
      device: previousDevice,
      multiRender: state.multiRender == MultiRender.devices
          ? MultiRender.none
          : state.multiRender,
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
