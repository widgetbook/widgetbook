import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/workbench/multi_render.dart';
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

      final renderModes = [
        RenderMode.widgetbook(),
        RenderMode.none(),
      ];

      test(
        'WorkbenchState<$ThemeData> defaults to the first item',
        () {
          final provider = WorkbenchProvider<ThemeData>(
            locales: locales,
            themes: themes,
            devices: devices,
            renderModes: renderModes,
          );

          expect(
            provider.state,
            equals(
              WorkbenchState<ThemeData>(
                renderMode: RenderMode.widgetbook(),
                theme: lightTheme,
                locale: usLocale,
                device: iPhone,
              ),
            ),
          );
        },
      );

      group(
        'changedMultiRender',
        () {
          test(
            '(${MultiRender.none}) sets locale, theme and device',
            () {
              final provider = WorkbenchProvider<ThemeData>(
                locales: locales,
                themes: themes,
                devices: devices,
                renderModes: renderModes,
              )..changedMultiRender(MultiRender.none);

              expect(
                provider.state,
                equals(
                  WorkbenchState<ThemeData>(
                    renderMode: RenderMode.widgetbook(),
                    theme: lightTheme,
                    locale: usLocale,
                    device: iPhone,
                  ),
                ),
              );
            },
          );

          test(
            '(${MultiRender.themes}) sets $MultiRender to value and themes to null',
            () {
              final provider = WorkbenchProvider<ThemeData>(
                locales: locales,
                themes: themes,
                devices: devices,
                renderModes: renderModes,
              )..changedMultiRender(MultiRender.themes);

              expect(
                provider.state,
                equals(
                  WorkbenchState<ThemeData>(
                    multiRender: MultiRender.themes,
                    renderMode: RenderMode.widgetbook(),
                    locale: usLocale,
                    device: iPhone,
                  ),
                ),
              );
            },
          );

          test(
            '(${MultiRender.devices}) sets $MultiRender to value and devices to null',
            () {
              final provider = WorkbenchProvider<ThemeData>(
                locales: locales,
                themes: themes,
                devices: devices,
                renderModes: renderModes,
              )..changedMultiRender(MultiRender.devices);

              expect(
                provider.state,
                equals(
                  WorkbenchState<ThemeData>(
                    multiRender: MultiRender.devices,
                    renderMode: RenderMode.widgetbook(),
                    theme: lightTheme,
                    locale: usLocale,
                  ),
                ),
              );
            },
          );

          test(
            '(${MultiRender.localization}) sets locale, theme and device',
            () {
              final provider = WorkbenchProvider<ThemeData>(
                locales: locales,
                themes: themes,
                devices: devices,
                renderModes: renderModes,
              )..changedMultiRender(MultiRender.themes);

              expect(
                provider.state,
                equals(
                  WorkbenchState<ThemeData>(
                    multiRender: MultiRender.themes,
                    renderMode: RenderMode.widgetbook(),
                    locale: usLocale,
                    device: iPhone,
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
                renderModes: renderModes,
              )..changedDevice(s21);

              expect(
                provider.state,
                equals(
                  WorkbenchState<ThemeData>(
                    renderMode: RenderMode.widgetbook(),
                    theme: lightTheme,
                    locale: usLocale,
                    device: s21,
                  ),
                ),
              );
            },
          );

          test(
            'sets active device to value if ${MultiRender.devices} is active',
            () {
              final provider = WorkbenchProvider<ThemeData>(
                locales: locales,
                themes: themes,
                devices: devices,
                renderModes: renderModes,
              )..changedDevice(s21);

              expect(
                provider.state,
                equals(
                  WorkbenchState<ThemeData>(
                    multiRender: MultiRender.none,
                    renderMode: RenderMode.widgetbook(),
                    theme: lightTheme,
                    locale: usLocale,
                    device: s21,
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
                renderModes: renderModes,
              )..changedTheme(darkTheme);

              expect(
                provider.state,
                equals(
                  WorkbenchState<ThemeData>(
                    renderMode: RenderMode.widgetbook(),
                    theme: darkTheme,
                    locale: usLocale,
                    device: iPhone,
                  ),
                ),
              );
            },
          );

          test(
            'sets active theme to value if ${MultiRender.themes} is active',
            () {
              final provider = WorkbenchProvider<ThemeData>(
                locales: locales,
                themes: themes,
                devices: devices,
                renderModes: renderModes,
              )..changedTheme(darkTheme);

              expect(
                provider.state,
                equals(
                  WorkbenchState<ThemeData>(
                    multiRender: MultiRender.none,
                    renderMode: RenderMode.widgetbook(),
                    theme: darkTheme,
                    locale: usLocale,
                    device: iPhone,
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
                renderModes: renderModes,
              )..changedLocale(deLocale);

              expect(
                provider.state,
                equals(
                  WorkbenchState<ThemeData>(
                    renderMode: RenderMode.widgetbook(),
                    theme: lightTheme,
                    locale: deLocale,
                    device: iPhone,
                  ),
                ),
              );
            },
          );

          test(
            'sets active locale to value if ${MultiRender.localization} is active',
            () {
              final provider = WorkbenchProvider<ThemeData>(
                locales: locales,
                themes: themes,
                devices: devices,
                renderModes: renderModes,
              )..changedTheme(darkTheme);

              expect(
                provider.state,
                equals(
                  WorkbenchState<ThemeData>(
                    multiRender: MultiRender.none,
                    renderMode: RenderMode.widgetbook(),
                    theme: darkTheme,
                    locale: usLocale,
                    device: iPhone,
                  ),
                ),
              );
            },
          );
        },
      );

      test(
        'changedRenderMode changed to value',
        () {
          final provider = WorkbenchProvider<ThemeData>(
            locales: locales,
            themes: themes,
            devices: devices,
            renderModes: renderModes,
          )..changedRenderMode(RenderMode.none());

          expect(
            provider.state,
            equals(
              WorkbenchState<ThemeData>(
                multiRender: MultiRender.none,
                renderMode: RenderMode.none(),
                theme: lightTheme,
                locale: usLocale,
                device: iPhone,
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
            renderModes: renderModes,
          )..nextTheme();

          expect(
            provider.state,
            equals(
              WorkbenchState<ThemeData>(
                multiRender: MultiRender.none,
                renderMode: RenderMode.widgetbook(),
                theme: darkTheme,
                locale: usLocale,
                device: iPhone,
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
            renderModes: renderModes,
          )..previousTheme();

          expect(
            provider.state,
            equals(
              WorkbenchState<ThemeData>(
                multiRender: MultiRender.none,
                renderMode: RenderMode.widgetbook(),
                theme: darkTheme,
                locale: usLocale,
                device: iPhone,
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
            renderModes: renderModes,
          )..nextDevice();

          expect(
            provider.state,
            equals(
              WorkbenchState<ThemeData>(
                multiRender: MultiRender.none,
                renderMode: RenderMode.widgetbook(),
                theme: lightTheme,
                locale: usLocale,
                device: s21,
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
            renderModes: renderModes,
          )..previousDevice();

          expect(
            provider.state,
            equals(
              WorkbenchState<ThemeData>(
                multiRender: MultiRender.none,
                renderMode: RenderMode.widgetbook(),
                theme: lightTheme,
                locale: usLocale,
                device: s21,
              ),
            ),
          );
        },
      );

      test(
        'nextRenderMode returns next $RenderMode',
        () {
          final provider = WorkbenchProvider<ThemeData>(
            locales: locales,
            themes: themes,
            devices: devices,
            renderModes: renderModes,
          )..nextRenderMode();

          expect(
            provider.state,
            equals(
              WorkbenchState<ThemeData>(
                multiRender: MultiRender.none,
                renderMode: RenderMode.none(),
                theme: lightTheme,
                locale: usLocale,
                device: iPhone,
              ),
            ),
          );
        },
      );

      test(
        'previousRenderMode returns previous $RenderMode',
        () {
          final provider = WorkbenchProvider<ThemeData>(
            locales: locales,
            themes: themes,
            devices: devices,
            renderModes: renderModes,
          )..previousRenderMode();

          expect(
            provider.state,
            equals(
              WorkbenchState<ThemeData>(
                multiRender: MultiRender.none,
                renderMode: RenderMode.none(),
                theme: lightTheme,
                locale: usLocale,
                device: iPhone,
              ),
            ),
          );
        },
      );
    },
  );
}
