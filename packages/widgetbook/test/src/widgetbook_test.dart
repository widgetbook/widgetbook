import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

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

      final categories = [
        WidgetbookCategory(name: 'A'),
      ];

      group(
        'constructor throws $AssertionError when',
        () {
          test(
            'categories is empty',
            () {
              expect(
                () => Widgetbook<ThemeData>(
                  addons: const [],
                  categories: const [],
                  appInfo: appInfo,
                ),
                expectAssertionErrorWithMessage(
                  message: 'Please specify at least one $WidgetbookCategory.',
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
                  categories: categories,
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
                  categories: categories,
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
                  categories: categories,
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
                  categories: categories,
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
                  categories: categories,
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
