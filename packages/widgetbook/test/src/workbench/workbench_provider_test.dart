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

      final frames = [
        WidgetbookFrame.defaultFrame(),
        WidgetbookFrame.noFrame(),
      ];

      test(
        'WorkbenchState<$ThemeData> defaults to the first item',
        () {
          final provider = WorkbenchProvider<ThemeData>(
            locales: locales,
            themes: themes,
            devices: devices,
            frames: frames,
          );

          expect(
            provider.state,
            equals(
              WorkbenchState<ThemeData>(
                frame: WidgetbookFrame.defaultFrame(),
                theme: lightTheme,
                locale: usLocale,
                device: iPhone,
                frames: frames,
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
                frames: frames,
              )..changedComparisonSetting(ComparisonSetting.none);

              expect(
                provider.state,
                equals(
                  WorkbenchState<ThemeData>(
                    frame: WidgetbookFrame.defaultFrame(),
                    theme: lightTheme,
                    locale: usLocale,
                    device: iPhone,
                    frames: frames,
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
                frames: frames,
              )..changedComparisonSetting(ComparisonSetting.themes);

              expect(
                provider.state,
                equals(
                  WorkbenchState<ThemeData>(
                    comparisonSetting: ComparisonSetting.themes,
                    frame: WidgetbookFrame.defaultFrame(),
                    locale: usLocale,
                    device: iPhone,
                    frames: frames,
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
                frames: frames,
              )..changedComparisonSetting(ComparisonSetting.devices);

              expect(
                provider.state,
                equals(
                  WorkbenchState<ThemeData>(
                    comparisonSetting: ComparisonSetting.devices,
                    frame: WidgetbookFrame.defaultFrame(),
                    theme: lightTheme,
                    locale: usLocale,
                    frames: frames,
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
                frames: frames,
              )..changedComparisonSetting(ComparisonSetting.themes);

              expect(
                provider.state,
                equals(
                  WorkbenchState<ThemeData>(
                    comparisonSetting: ComparisonSetting.themes,
                    frame: WidgetbookFrame.defaultFrame(),
                    locale: usLocale,
                    device: iPhone,
                    frames: frames,
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
                frames: frames,
              )..changedDevice(s21);

              expect(
                provider.state,
                equals(
                  WorkbenchState<ThemeData>(
                    frame: WidgetbookFrame.defaultFrame(),
                    theme: lightTheme,
                    locale: usLocale,
                    device: s21,
                    frames: frames,
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
                frames: frames,
              )..changedDevice(s21);

              expect(
                provider.state,
                equals(
                  WorkbenchState<ThemeData>(
                    comparisonSetting: ComparisonSetting.none,
                    frame: WidgetbookFrame.defaultFrame(),
                    theme: lightTheme,
                    locale: usLocale,
                    device: s21,
                    frames: frames,
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
                frames: frames,
              )..changedTheme(darkTheme);

              expect(
                provider.state,
                equals(
                  WorkbenchState<ThemeData>(
                    frame: WidgetbookFrame.defaultFrame(),
                    theme: darkTheme,
                    locale: usLocale,
                    device: iPhone,
                    frames: frames,
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
                frames: frames,
              )..changedTheme(darkTheme);

              expect(
                provider.state,
                equals(
                  WorkbenchState<ThemeData>(
                    comparisonSetting: ComparisonSetting.none,
                    frame: WidgetbookFrame.defaultFrame(),
                    theme: darkTheme,
                    locale: usLocale,
                    device: iPhone,
                    frames: frames,
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
                frames: frames,
              )..changedLocale(deLocale);

              expect(
                provider.state,
                equals(
                  WorkbenchState<ThemeData>(
                    frame: WidgetbookFrame.defaultFrame(),
                    theme: lightTheme,
                    locale: deLocale,
                    device: iPhone,
                    frames: frames,
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
                frames: frames,
              )..changedTheme(darkTheme);

              expect(
                provider.state,
                equals(
                  WorkbenchState<ThemeData>(
                    comparisonSetting: ComparisonSetting.none,
                    frame: WidgetbookFrame.defaultFrame(),
                    theme: darkTheme,
                    locale: usLocale,
                    device: iPhone,
                    frames: frames,
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
            frames: frames,
          )..changedDeviceFrame(WidgetbookFrame.noFrame());

          expect(
            provider.state,
            equals(
              WorkbenchState<ThemeData>(
                comparisonSetting: ComparisonSetting.none,
                frame: WidgetbookFrame.noFrame(),
                theme: lightTheme,
                locale: usLocale,
                device: iPhone,
                frames: frames,
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
            frames: frames,
          )..nextTheme();

          expect(
            provider.state,
            equals(
              WorkbenchState<ThemeData>(
                comparisonSetting: ComparisonSetting.none,
                frame: WidgetbookFrame.defaultFrame(),
                theme: darkTheme,
                locale: usLocale,
                device: iPhone,
                frames: frames,
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
            frames: frames,
          )..previousTheme();

          expect(
            provider.state,
            equals(
              WorkbenchState<ThemeData>(
                comparisonSetting: ComparisonSetting.none,
                frame: WidgetbookFrame.defaultFrame(),
                theme: darkTheme,
                locale: usLocale,
                device: iPhone,
                frames: frames,
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
            frames: frames,
          )..nextDevice();

          expect(
            provider.state,
            equals(
              WorkbenchState<ThemeData>(
                comparisonSetting: ComparisonSetting.none,
                frame: WidgetbookFrame.defaultFrame(),
                theme: lightTheme,
                locale: usLocale,
                device: s21,
                frames: frames,
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
            frames: frames,
          )..previousDevice();

          expect(
            provider.state,
            equals(
              WorkbenchState<ThemeData>(
                comparisonSetting: ComparisonSetting.none,
                frame: WidgetbookFrame.defaultFrame(),
                theme: lightTheme,
                locale: usLocale,
                device: s21,
                frames: frames,
                locales: locales,
                themes: themes,
                devices: devices,
              ),
            ),
          );
        },
      );

      test(
        'nextDeviceFrame returns next $WidgetbookFrame',
        () {
          final provider = WorkbenchProvider<ThemeData>(
            locales: locales,
            themes: themes,
            devices: devices,
            frames: frames,
          )..nextDeviceFrame();

          expect(
            provider.state,
            equals(
              WorkbenchState<ThemeData>(
                comparisonSetting: ComparisonSetting.none,
                frame: WidgetbookFrame.noFrame(),
                theme: lightTheme,
                locale: usLocale,
                device: iPhone,
                frames: frames,
                locales: locales,
                themes: themes,
                devices: devices,
              ),
            ),
          );
        },
      );

      test(
        'previousDeviceFrame returns previous $WidgetbookFrame',
        () {
          final provider = WorkbenchProvider<ThemeData>(
            locales: locales,
            themes: themes,
            devices: devices,
            frames: frames,
          )..previousDeviceFrame();

          expect(
            provider.state,
            equals(
              WorkbenchState<ThemeData>(
                comparisonSetting: ComparisonSetting.none,
                frame: WidgetbookFrame.noFrame(),
                theme: lightTheme,
                locale: usLocale,
                device: iPhone,
                frames: frames,
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
