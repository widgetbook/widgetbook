import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/workbench/comparison_setting.dart';
import 'package:widgetbook/src/workbench/workbench_provider.dart';
import 'package:widgetbook/src/workbench/workbench_state.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  group(
    '$WorkbenchProvider',
    () {
      const usLocale = Locale('us');
      const deLocale = Locale('de');
      const locales = [
        usLocale,
        deLocale,
      ];

      final lightTheme = WidgetbookTheme(
        name: 'light',
        data: ThemeData.light(),
      );
      final darkTheme = WidgetbookTheme(
        name: 'light',
        data: ThemeData.dark(),
      );
      final themes = [
        lightTheme,
        darkTheme,
      ];

      const iPhone = Apple.iPhone11;
      const s21 = Samsung.s21ultra;
      const devices = [
        iPhone,
        s21,
      ];

      final deviceFrames = [
        DeviceFrame.widgetbook(),
        DeviceFrame.none(),
      ];

      test(
        'WorkbenchState<$ThemeData> defaults to the first item',
        () {
          final provider = WorkbenchProvider<ThemeData>(
            locales: locales,
            themes: themes,
            devices: devices,
            deviceFrames: deviceFrames,
          );

          expect(
            provider.state,
            equals(
              WorkbenchState<ThemeData>(
                deviceFrame: DeviceFrame.widgetbook(),
                theme: lightTheme,
                locale: usLocale,
                device: iPhone,
                deviceFrames: deviceFrames,
                locales: locales,
                themes: themes,
                devices: devices,
              ),
            ),
          );
        },
      );

      group(
        'changedComparisonSetting',
        () {
          test(
            '(${ComparisonSetting.none}) sets locale, theme and device',
            () {
              final provider = WorkbenchProvider<ThemeData>(
                locales: locales,
                themes: themes,
                devices: devices,
                deviceFrames: deviceFrames,
              )..changedComparisonSetting(ComparisonSetting.none);

              expect(
                provider.state,
                equals(
                  WorkbenchState<ThemeData>(
                    deviceFrame: DeviceFrame.widgetbook(),
                    theme: lightTheme,
                    locale: usLocale,
                    device: iPhone,
                    deviceFrames: deviceFrames,
                    locales: locales,
                    themes: themes,
                    devices: devices,
                  ),
                ),
              );
            },
          );

          test(
            '(${ComparisonSetting.themes}) sets $ComparisonSetting to value and themes to null',
            () {
              final provider = WorkbenchProvider<ThemeData>(
                locales: locales,
                themes: themes,
                devices: devices,
                deviceFrames: deviceFrames,
              )..changedComparisonSetting(ComparisonSetting.themes);

              expect(
                provider.state,
                equals(
                  WorkbenchState<ThemeData>(
                    comparisonSetting: ComparisonSetting.themes,
                    deviceFrame: DeviceFrame.widgetbook(),
                    locale: usLocale,
                    device: iPhone,
                    deviceFrames: deviceFrames,
                    locales: locales,
                    themes: themes,
                    devices: devices,
                  ),
                ),
              );
            },
          );

          test(
            '(${ComparisonSetting.devices}) sets $ComparisonSetting to value and devices to null',
            () {
              final provider = WorkbenchProvider<ThemeData>(
                locales: locales,
                themes: themes,
                devices: devices,
                deviceFrames: deviceFrames,
              )..changedComparisonSetting(ComparisonSetting.devices);

              expect(
                provider.state,
                equals(
                  WorkbenchState<ThemeData>(
                    comparisonSetting: ComparisonSetting.devices,
                    deviceFrame: DeviceFrame.widgetbook(),
                    theme: lightTheme,
                    locale: usLocale,
                    deviceFrames: deviceFrames,
                    locales: locales,
                    themes: themes,
                    devices: devices,
                  ),
                ),
              );
            },
          );

          test(
            '(${ComparisonSetting.localization}) sets locale, theme and device',
            () {
              final provider = WorkbenchProvider<ThemeData>(
                locales: locales,
                themes: themes,
                devices: devices,
                deviceFrames: deviceFrames,
              )..changedComparisonSetting(ComparisonSetting.themes);

              expect(
                provider.state,
                equals(
                  WorkbenchState<ThemeData>(
                    comparisonSetting: ComparisonSetting.themes,
                    deviceFrame: DeviceFrame.widgetbook(),
                    locale: usLocale,
                    device: iPhone,
                    deviceFrames: deviceFrames,
                    locales: locales,
                    themes: themes,
                    devices: devices,
                  ),
                ),
              );
            },
          );
        },
      );

      group(
        'changedDevice',
        () {
          test(
            'sets active device to value',
            () {
              final provider = WorkbenchProvider<ThemeData>(
                locales: locales,
                themes: themes,
                devices: devices,
                deviceFrames: deviceFrames,
              )..changedDevice(s21);

              expect(
                provider.state,
                equals(
                  WorkbenchState<ThemeData>(
                    deviceFrame: DeviceFrame.widgetbook(),
                    theme: lightTheme,
                    locale: usLocale,
                    device: s21,
                    deviceFrames: deviceFrames,
                    locales: locales,
                    themes: themes,
                    devices: devices,
                  ),
                ),
              );
            },
          );

          test(
            'sets active device to value if ${ComparisonSetting.devices} is active',
            () {
              final provider = WorkbenchProvider<ThemeData>(
                locales: locales,
                themes: themes,
                devices: devices,
                deviceFrames: deviceFrames,
              )..changedDevice(s21);

              expect(
                provider.state,
                equals(
                  WorkbenchState<ThemeData>(
                    comparisonSetting: ComparisonSetting.none,
                    deviceFrame: DeviceFrame.widgetbook(),
                    theme: lightTheme,
                    locale: usLocale,
                    device: s21,
                    deviceFrames: deviceFrames,
                    locales: locales,
                    themes: themes,
                    devices: devices,
                  ),
                ),
              );
            },
          );
        },
      );

      group(
        'changedTheme',
        () {
          test(
            'sets active theme to value',
            () {
              final provider = WorkbenchProvider<ThemeData>(
                locales: locales,
                themes: themes,
                devices: devices,
                deviceFrames: deviceFrames,
              )..changedTheme(darkTheme);

              expect(
                provider.state,
                equals(
                  WorkbenchState<ThemeData>(
                    deviceFrame: DeviceFrame.widgetbook(),
                    theme: darkTheme,
                    locale: usLocale,
                    device: iPhone,
                    deviceFrames: deviceFrames,
                    locales: locales,
                    themes: themes,
                    devices: devices,
                  ),
                ),
              );
            },
          );

          test(
            'sets active theme to value if ${ComparisonSetting.themes} is active',
            () {
              final provider = WorkbenchProvider<ThemeData>(
                locales: locales,
                themes: themes,
                devices: devices,
                deviceFrames: deviceFrames,
              )..changedTheme(darkTheme);

              expect(
                provider.state,
                equals(
                  WorkbenchState<ThemeData>(
                    comparisonSetting: ComparisonSetting.none,
                    deviceFrame: DeviceFrame.widgetbook(),
                    theme: darkTheme,
                    locale: usLocale,
                    device: iPhone,
                    deviceFrames: deviceFrames,
                    locales: locales,
                    themes: themes,
                    devices: devices,
                  ),
                ),
              );
            },
          );
        },
      );

      group(
        'changedLocale',
        () {
          test(
            'sets active locale to value',
            () {
              final provider = WorkbenchProvider<ThemeData>(
                locales: locales,
                themes: themes,
                devices: devices,
                deviceFrames: deviceFrames,
              )..changedLocale(deLocale);

              expect(
                provider.state,
                equals(
                  WorkbenchState<ThemeData>(
                    deviceFrame: DeviceFrame.widgetbook(),
                    theme: lightTheme,
                    locale: deLocale,
                    device: iPhone,
                    deviceFrames: deviceFrames,
                    locales: locales,
                    themes: themes,
                    devices: devices,
                  ),
                ),
              );
            },
          );

          test(
            'sets active locale to value if ${ComparisonSetting.localization} is active',
            () {
              final provider = WorkbenchProvider<ThemeData>(
                locales: locales,
                themes: themes,
                devices: devices,
                deviceFrames: deviceFrames,
              )..changedTheme(darkTheme);

              expect(
                provider.state,
                equals(
                  WorkbenchState<ThemeData>(
                    comparisonSetting: ComparisonSetting.none,
                    deviceFrame: DeviceFrame.widgetbook(),
                    theme: darkTheme,
                    locale: usLocale,
                    device: iPhone,
                    deviceFrames: deviceFrames,
                    locales: locales,
                    themes: themes,
                    devices: devices,
                  ),
                ),
              );
            },
          );
        },
      );

      test(
        'changedDeviceFrame changed to value',
        () {
          final provider = WorkbenchProvider<ThemeData>(
            locales: locales,
            themes: themes,
            devices: devices,
            deviceFrames: deviceFrames,
          )..changedDeviceFrame(DeviceFrame.none());

          expect(
            provider.state,
            equals(
              WorkbenchState<ThemeData>(
                comparisonSetting: ComparisonSetting.none,
                deviceFrame: DeviceFrame.none(),
                theme: lightTheme,
                locale: usLocale,
                device: iPhone,
                deviceFrames: deviceFrames,
                locales: locales,
                themes: themes,
                devices: devices,
              ),
            ),
          );
        },
      );

      test(
        'nextTheme returns next theme',
        () {
          final provider = WorkbenchProvider<ThemeData>(
            locales: locales,
            themes: themes,
            devices: devices,
            deviceFrames: deviceFrames,
          )..nextTheme();

          expect(
            provider.state,
            equals(
              WorkbenchState<ThemeData>(
                comparisonSetting: ComparisonSetting.none,
                deviceFrame: DeviceFrame.widgetbook(),
                theme: darkTheme,
                locale: usLocale,
                device: iPhone,
                deviceFrames: deviceFrames,
                locales: locales,
                themes: themes,
                devices: devices,
              ),
            ),
          );
        },
      );

      test(
        'previousTheme returns previous theme',
        () {
          final provider = WorkbenchProvider<ThemeData>(
            locales: locales,
            themes: themes,
            devices: devices,
            deviceFrames: deviceFrames,
          )..previousTheme();

          expect(
            provider.state,
            equals(
              WorkbenchState<ThemeData>(
                comparisonSetting: ComparisonSetting.none,
                deviceFrame: DeviceFrame.widgetbook(),
                theme: darkTheme,
                locale: usLocale,
                device: iPhone,
                deviceFrames: deviceFrames,
                locales: locales,
                themes: themes,
                devices: devices,
              ),
            ),
          );
        },
      );

      test(
        'nextDevice returns next device',
        () {
          final provider = WorkbenchProvider<ThemeData>(
            locales: locales,
            themes: themes,
            devices: devices,
            deviceFrames: deviceFrames,
          )..nextDevice();

          expect(
            provider.state,
            equals(
              WorkbenchState<ThemeData>(
                comparisonSetting: ComparisonSetting.none,
                deviceFrame: DeviceFrame.widgetbook(),
                theme: lightTheme,
                locale: usLocale,
                device: s21,
                deviceFrames: deviceFrames,
                locales: locales,
                themes: themes,
                devices: devices,
              ),
            ),
          );
        },
      );

      test(
        'previousDevice returns previous device',
        () {
          final provider = WorkbenchProvider<ThemeData>(
            locales: locales,
            themes: themes,
            devices: devices,
            deviceFrames: deviceFrames,
          )..previousDevice();

          expect(
            provider.state,
            equals(
              WorkbenchState<ThemeData>(
                comparisonSetting: ComparisonSetting.none,
                deviceFrame: DeviceFrame.widgetbook(),
                theme: lightTheme,
                locale: usLocale,
                device: s21,
                deviceFrames: deviceFrames,
                locales: locales,
                themes: themes,
                devices: devices,
              ),
            ),
          );
        },
      );

      test(
        'nextDeviceFrame returns next $DeviceFrame',
        () {
          final provider = WorkbenchProvider<ThemeData>(
            locales: locales,
            themes: themes,
            devices: devices,
            deviceFrames: deviceFrames,
          )..nextDeviceFrame();

          expect(
            provider.state,
            equals(
              WorkbenchState<ThemeData>(
                comparisonSetting: ComparisonSetting.none,
                deviceFrame: DeviceFrame.none(),
                theme: lightTheme,
                locale: usLocale,
                device: iPhone,
                deviceFrames: deviceFrames,
                locales: locales,
                themes: themes,
                devices: devices,
              ),
            ),
          );
        },
      );

      test(
        'previousDeviceFrame returns previous $DeviceFrame',
        () {
          final provider = WorkbenchProvider<ThemeData>(
            locales: locales,
            themes: themes,
            devices: devices,
            deviceFrames: deviceFrames,
          )..previousDeviceFrame();

          expect(
            provider.state,
            equals(
              WorkbenchState<ThemeData>(
                comparisonSetting: ComparisonSetting.none,
                deviceFrame: DeviceFrame.none(),
                theme: lightTheme,
                locale: usLocale,
                device: iPhone,
                deviceFrames: deviceFrames,
                locales: locales,
                themes: themes,
                devices: devices,
              ),
            ),
          );
        },
      );
    },
  );
}
