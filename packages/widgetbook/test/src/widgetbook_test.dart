import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
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
            'textScaleFactors is empty',
            () {
              expect(
                () => Widgetbook(
                  appBuilder: _defaultAppBuilderMethod,
                  addons: [
                    TextScaleAddon(
                      scales: [],
                    )
                  ],
                ),
                expectAssertionErrorWithMessage(
                  message: 'scales cannot be empty',
                ),
              );
            },
          );

          test(
            'themes is empty',
            () {
              expect(
                () => Widgetbook(
                  appBuilder: _defaultAppBuilderMethod,
                  addons: [
                    MaterialThemeAddon(
                      themes: const [],
                    ),
                  ],
                ),
                expectAssertionErrorWithMessage(
                  message: 'themes cannot be empty',
                ),
              );
            },
          );

          test(
            'devices is empty',
            () {
              expect(
                () => Widgetbook(
                  appBuilder: _defaultAppBuilderMethod,
                  addons: [
                    DeviceAddon(
                      devices: [],
                    ),
                  ],
                ),
                expectAssertionErrorWithMessage(
                  message: 'devices cannot be empty',
                ),
              );
            },
          );

          test(
            'supportedLocales is empty',
            () {
              expect(
                () => Widgetbook(
                  appBuilder: _defaultAppBuilderMethod,
                  addons: [
                    LocalizationAddon(
                      locales: [],
                      localizationsDelegates: [],
                    ),
                  ],
                ),
                expectAssertionErrorWithMessage(
                  message: 'locales cannot be empty',
                ),
              );
            },
          );
        },
      );
    },
  );
}
