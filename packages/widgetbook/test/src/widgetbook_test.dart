import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

Matcher expectAssertionErrorWithMessage({
  required String message,
}) {
  return throwsA(
    allOf(
      isA<AssertionError>(),
      predicate<AssertionError>(
        (e) => e.message == message,
      ),
    ),
  );
}

Widget _defaultAppBuilderMethod(
  BuildContext context,
  Widget child,
) {
  return WidgetsApp(
    color: Colors.transparent,
    debugShowCheckedModeBanner: false,
    builder: (context, childWidget) {
      return childWidget ?? child;
    },
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
                  directories: [],
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
                  directories: [],
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
                  directories: [],
                  appBuilder: _defaultAppBuilderMethod,
                  addons: [
                    DeviceFrameAddon(
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
                  directories: [],
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
