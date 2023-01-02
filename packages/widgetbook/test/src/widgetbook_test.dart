import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

Matcher expectAssertionErrorWithMessage({
  required String message,
}) {
  return throwsA(
    allOf(
      isA<AssertionError>(),
      predicate(
        (AssertionError e) => e.message == message,
      ),
    ),
  );
}

void main() {
  group(
    '$Widgetbook',
    () {
      final appInfo = AppInfo(
        name: 'A',
      );

      final children = [
        WidgetbookCategory(name: 'A', children: const []),
      ];

      group(
        'constructor throws $AssertionError when',
        () {
          test(
            'Navigation tree children are empty',
            () {
              expect(
                () => Widgetbook<ThemeData>(
                  addons: const [],
                  appInfo: appInfo,
                ),
                expectAssertionErrorWithMessage(
                  message: 'Please specify at least one $MultiChildNavigationNodeData.',
                ),
              );
            },
          );

          test(
            'devices is empty',
            () {
              expect(
                () => Widgetbook<ThemeData>(
                  addons: [
                    FrameAddon(
                      setting: FrameSetting.firstAsSelected(
                        frames: [
                          DefaultDeviceFrame(
                            setting: DeviceSetting.firstAsSelected(
                              devices: [],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                  appInfo: appInfo,
                ),
                expectAssertionErrorWithMessage(
                  message: 'Please specify at least one $Device',
                ),
              );
            },
          );

          test(
            'textScaleFactors is empty',
            () {
              expect(
                () => Widgetbook<ThemeData>(
                  addons: [
                    TextScaleAddon(
                      setting: TextScaleSetting.firstAsSelected(
                        textScales: [],
                      ),
                    )
                  ],
                  appInfo: appInfo,
                ),
                expectAssertionErrorWithMessage(
                  message: 'Please specify at least one TextScaleFactor',
                ),
              );
            },
          );

          test(
            'themes is empty',
            () {
              expect(
                () => Widgetbook<ThemeData>(
                  addons: [
                    MaterialThemeAddon(
                      setting: MaterialThemeSetting.firstAsSelected(
                        themes: [],
                      ),
                    ),
                  ],
                  appInfo: appInfo,
                ),
                expectAssertionErrorWithMessage(
                  message: 'Please specify at least one Theme',
                ),
              );
            },
          );

          test(
            'frames is empty',
            () {
              expect(
                () => Widgetbook<ThemeData>(
                  addons: [
                    FrameAddon(
                      setting: FrameSetting.firstAsSelected(
                        frames: [],
                      ),
                    ),
                  ],
                  appInfo: appInfo,
                ),
                expectAssertionErrorWithMessage(
                  message: 'Please specify at least one Frame',
                ),
              );
            },
          );

          test(
            'supportedLocales is empty',
            () {
              expect(
                () => Widgetbook<ThemeData>(
                  addons: [
                    LocalizationAddon(
                      setting: LocalizationSetting.firstAsSelected(
                        locales: [],
                        localizationsDelegates: [],
                      ),
                    )
                  ],
                  appInfo: appInfo,
                ),
                expectAssertionErrorWithMessage(
                  message: 'Please specify at least one supported $Locale.',
                ),
              );
            },
          );
        },
      );
    },
  );
}
