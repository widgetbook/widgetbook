import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
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

GoRouter _getRouter(Widget child) {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => child,
      ),
    ],
  );
}

Widget _defaultAppBuilderMethod(BuildContext context, Widget child) {
  final router = _getRouter(child);
  return WidgetsApp.router(
    color: Colors.transparent,
    builder: (context, childWidget) {
      return childWidget ?? child;
    },
    debugShowCheckedModeBanner: false,
    routeInformationParser: router.routeInformationParser,
    routerDelegate: router.routerDelegate,
  );
}

void main() {
  group(
    '$Widgetbook',
    () {
      group(
        'constructor throws $AssertionError when',
        () {
          test(
            'Navigation tree children are empty',
            () {
              expect(
                () => Widgetbook<ThemeData>(
                  addons: const [],
                  appBuilder: _defaultAppBuilderMethod,
                ),
                expectAssertionErrorWithMessage(
                  message:
                      'Please specify at least one $MultiChildNavigationNodeData.',
                ),
              );
            },
          );

          test(
            'devices is empty',
            () {
              expect(
                () => Widgetbook<ThemeData>(
                  appBuilder: _defaultAppBuilderMethod,
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
                  appBuilder: _defaultAppBuilderMethod,
                  addons: [
                    TextScaleAddon(
                      setting: TextScaleSetting.firstAsSelected(
                        textScales: [],
                      ),
                    )
                  ],
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
                  appBuilder: _defaultAppBuilderMethod,
                  addons: [
                    MaterialThemeAddon(
                      setting: MaterialThemeSetting.firstAsSelected(
                        themes: [],
                      ),
                    ),
                  ],
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
                  appBuilder: _defaultAppBuilderMethod,
                  addons: [
                    FrameAddon(
                      setting: FrameSetting.firstAsSelected(
                        frames: [],
                      ),
                    ),
                  ],
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
                  appBuilder: _defaultAppBuilderMethod,
                  addons: [
                    LocalizationAddon(
                      setting: LocalizationSetting.firstAsSelected(
                        locales: [],
                        localizationsDelegates: [],
                      ),
                    )
                  ],
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
