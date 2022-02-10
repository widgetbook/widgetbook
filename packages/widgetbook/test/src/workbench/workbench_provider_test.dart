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

      const textScaleFactor1 = 1.0;
      const textScaleFactor2 = 2.0;
      final textScaleFactors = [
        textScaleFactor1,
        textScaleFactor2,
      ];

      test(
        'WorkbenchState<$ThemeData> defaults to the first item',
        () {
          final provider = WorkbenchProvider<ThemeData>(
            locales: locales,
            themes: themes,
            devices: devices,
            frames: frames,
            textScaleFactors: textScaleFactors,
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
                textScaleFactor: textScaleFactor1,
                locales: locales,
                themes: themes,
                devices: devices,
                textScaleFactors: textScaleFactors,
              ),
            ),
          );
        },
      );

      group(
        'changedComparisonSetting',
        () {
          test(
            '(${ComparisonSetting.none}) sets locale, theme, device and textScaleFactor to a value not null',
            () {
              final provider = WorkbenchProvider<ThemeData>(
                locales: locales,
                themes: themes,
                devices: devices,
                frames: frames,
                textScaleFactors: textScaleFactors,
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
                    textScaleFactor: textScaleFactor1,
                    locales: locales,
                    themes: themes,
                    devices: devices,
                    textScaleFactors: textScaleFactors,
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
                textScaleFactors: textScaleFactors,
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
                    textScaleFactor: textScaleFactor1,
                    locales: locales,
                    themes: themes,
                    devices: devices,
                    textScaleFactors: textScaleFactors,
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
                textScaleFactors: textScaleFactors,
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
                    textScaleFactor: textScaleFactor1,
                    locales: locales,
                    themes: themes,
                    devices: devices,
                    textScaleFactors: textScaleFactors,
                  ),
                ),
              );
            },
          );

          test(
            '(${ComparisonSetting.localization}) sets $ComparisonSetting to value and locale to null',
            () {
              final provider = WorkbenchProvider<ThemeData>(
                locales: locales,
                themes: themes,
                devices: devices,
                frames: frames,
                textScaleFactors: textScaleFactors,
              )..changedComparisonSetting(ComparisonSetting.themes);

              expect(
                provider.state,
                equals(
                  WorkbenchState<ThemeData>(
                    comparisonSetting: ComparisonSetting.themes,
                    frame: WidgetbookFrame.defaultFrame(),
                    locale: usLocale,
                    device: iPhone,
                    textScaleFactor: textScaleFactor1,
                    frames: frames,
                    locales: locales,
                    themes: themes,
                    devices: devices,
                    textScaleFactors: textScaleFactors,
                  ),
                ),
              );
            },
          );

          test(
            '(${ComparisonSetting.textScale}) sets $ComparisonSetting to value and textScale to null',
            () {
              final provider = WorkbenchProvider<ThemeData>(
                locales: locales,
                themes: themes,
                devices: devices,
                frames: frames,
                textScaleFactors: textScaleFactors,
              )..changedComparisonSetting(ComparisonSetting.textScale);

              expect(
                provider.state,
                equals(
                  WorkbenchState<ThemeData>(
                    comparisonSetting: ComparisonSetting.textScale,
                    frame: WidgetbookFrame.defaultFrame(),
                    locale: usLocale,
                    device: iPhone,
                    theme: lightTheme,
                    textScaleFactor: null,
                    frames: frames,
                    locales: locales,
                    themes: themes,
                    devices: devices,
                    textScaleFactors: textScaleFactors,
                  ),
                ),
              );
            },
          );
        },
      );

      group(
        'toggledOrientation',
        () {
          test(
            'changes ${Orientation.portrait} to ${Orientation.landscape}',
            () {
              final provider = WorkbenchProvider<ThemeData>(
                locales: locales,
                themes: themes,
                devices: devices,
                frames: frames,
                textScaleFactors: textScaleFactors,
              )..toggledOrientation();

              expect(
                provider.state,
                equals(
                  WorkbenchState<ThemeData>(
                    frame: WidgetbookFrame.defaultFrame(),
                    theme: lightTheme,
                    locale: usLocale,
                    device: iPhone,
                    textScaleFactor: textScaleFactor1,
                    frames: frames,
                    locales: locales,
                    themes: themes,
                    devices: devices,
                    textScaleFactors: textScaleFactors,
                    orientation: Orientation.landscape,
                  ),
                ),
              );

              provider.toggledOrientation();

              expect(
                provider.state,
                equals(
                  WorkbenchState<ThemeData>(
                    frame: WidgetbookFrame.defaultFrame(),
                    theme: lightTheme,
                    locale: usLocale,
                    device: iPhone,
                    textScaleFactor: textScaleFactor1,
                    frames: frames,
                    locales: locales,
                    themes: themes,
                    devices: devices,
                    textScaleFactors: textScaleFactors,
                    orientation: Orientation.portrait,
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
                textScaleFactors: textScaleFactors,
              )..changedDevice(s21);

              expect(
                provider.state,
                equals(
                  WorkbenchState<ThemeData>(
                    frame: WidgetbookFrame.defaultFrame(),
                    theme: lightTheme,
                    locale: usLocale,
                    device: s21,
                    textScaleFactor: textScaleFactor1,
                    frames: frames,
                    locales: locales,
                    themes: themes,
                    devices: devices,
                    textScaleFactors: textScaleFactors,
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
                textScaleFactors: textScaleFactors,
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
                    textScaleFactor: textScaleFactor1,
                    frames: frames,
                    locales: locales,
                    themes: themes,
                    devices: devices,
                    textScaleFactors: textScaleFactors,
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
                textScaleFactors: textScaleFactors,
              )..changedTheme(darkTheme);

              expect(
                provider.state,
                equals(
                  WorkbenchState<ThemeData>(
                    frame: WidgetbookFrame.defaultFrame(),
                    theme: darkTheme,
                    locale: usLocale,
                    device: iPhone,
                    textScaleFactor: textScaleFactor1,
                    frames: frames,
                    locales: locales,
                    themes: themes,
                    devices: devices,
                    textScaleFactors: textScaleFactors,
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
                textScaleFactors: textScaleFactors,
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
                    textScaleFactor: textScaleFactor1,
                    frames: frames,
                    locales: locales,
                    themes: themes,
                    devices: devices,
                    textScaleFactors: textScaleFactors,
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
                textScaleFactors: textScaleFactors,
              )..changedLocale(deLocale);

              expect(
                provider.state,
                equals(
                  WorkbenchState<ThemeData>(
                    frame: WidgetbookFrame.defaultFrame(),
                    theme: lightTheme,
                    locale: deLocale,
                    device: iPhone,
                    textScaleFactor: textScaleFactor1,
                    frames: frames,
                    locales: locales,
                    themes: themes,
                    devices: devices,
                    textScaleFactors: textScaleFactors,
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
                textScaleFactors: textScaleFactors,
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
                    textScaleFactor: textScaleFactor1,
                    frames: frames,
                    locales: locales,
                    themes: themes,
                    devices: devices,
                    textScaleFactors: textScaleFactors,
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
            textScaleFactors: textScaleFactors,
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
                textScaleFactor: textScaleFactor1,
                frames: frames,
                locales: locales,
                themes: themes,
                devices: devices,
                textScaleFactors: textScaleFactors,
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
            textScaleFactors: textScaleFactors,
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
                textScaleFactor: textScaleFactor1,
                frames: frames,
                locales: locales,
                themes: themes,
                devices: devices,
                textScaleFactors: textScaleFactors,
              ),
            ),
          );
        },
      );

      group(
        'changedTextScale',
        () {
          test(
            'sets active text scale to value',
            () {
              final provider = WorkbenchProvider<ThemeData>(
                locales: locales,
                themes: themes,
                devices: devices,
                frames: frames,
                textScaleFactors: textScaleFactors,
              )..changedTextScaleFactor(textScaleFactor2);

              expect(
                provider.state,
                equals(
                  WorkbenchState<ThemeData>(
                    frame: WidgetbookFrame.defaultFrame(),
                    theme: lightTheme,
                    locale: usLocale,
                    device: iPhone,
                    textScaleFactor: textScaleFactor2,
                    frames: frames,
                    locales: locales,
                    themes: themes,
                    devices: devices,
                    textScaleFactors: textScaleFactors,
                  ),
                ),
              );
            },
          );

          test(
            'sets active theme to value if ${ComparisonSetting.textScale} is active',
            () {
              final provider = WorkbenchProvider<ThemeData>(
                locales: locales,
                themes: themes,
                devices: devices,
                frames: frames,
                textScaleFactors: textScaleFactors,
              )..changedTextScaleFactor(textScaleFactor1);

              expect(
                provider.state,
                equals(
                  WorkbenchState<ThemeData>(
                    comparisonSetting: ComparisonSetting.none,
                    frame: WidgetbookFrame.defaultFrame(),
                    theme: lightTheme,
                    locale: usLocale,
                    device: iPhone,
                    textScaleFactor: textScaleFactor1,
                    frames: frames,
                    locales: locales,
                    themes: themes,
                    devices: devices,
                    textScaleFactors: textScaleFactors,
                  ),
                ),
              );
            },
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
            textScaleFactors: textScaleFactors,
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
                textScaleFactor: textScaleFactor1,
                frames: frames,
                locales: locales,
                themes: themes,
                devices: devices,
                textScaleFactors: textScaleFactors,
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
            textScaleFactors: textScaleFactors,
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
                textScaleFactor: textScaleFactor1,
                frames: frames,
                locales: locales,
                themes: themes,
                devices: devices,
                textScaleFactors: textScaleFactors,
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
            textScaleFactors: textScaleFactors,
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
                textScaleFactor: textScaleFactor1,
                frames: frames,
                locales: locales,
                themes: themes,
                devices: devices,
                textScaleFactors: textScaleFactors,
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
            textScaleFactors: textScaleFactors,
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
                textScaleFactor: textScaleFactor1,
                frames: frames,
                locales: locales,
                themes: themes,
                devices: devices,
                textScaleFactors: textScaleFactors,
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
            textScaleFactors: textScaleFactors,
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
                textScaleFactor: textScaleFactor1,
                frames: frames,
                locales: locales,
                themes: themes,
                devices: devices,
                textScaleFactors: textScaleFactors,
              ),
            ),
          );
        },
      );
    },
  );
}
