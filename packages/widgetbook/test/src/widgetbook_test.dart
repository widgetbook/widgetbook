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
      final themes = [
        WidgetbookTheme(
          name: 'Light',
          data: ThemeData.light(),
        ),
      ];

      group(
        'constructor throws $AssertionError when',
        () {
          test(
            'categories is empty',
            () {
              expect(
                () => Widgetbook(
                  categories: const [],
                  appInfo: appInfo,
                  themes: themes,
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
                () => Widgetbook(
                  categories: categories,
                  appInfo: appInfo,
                  themes: themes,
                  devices: const [],
                ),
                expectAssertionErrorWithMessage(
                  message: 'Please specify at least one $Device.',
                ),
              );
            },
          );

          test(
            'themes is empty',
            () {
              expect(
                () => Widgetbook(
                  categories: categories,
                  appInfo: appInfo,
                  themes: const [],
                ),
                expectAssertionErrorWithMessage(
                  message: 'Please specify at least one $WidgetbookTheme.',
                ),
              );
            },
          );

          test(
            'deviceFrames is empty',
            () {
              expect(
                () => Widgetbook(
                  categories: categories,
                  appInfo: appInfo,
                  themes: themes,
                  deviceFrames: const [],
                ),
                expectAssertionErrorWithMessage(
                  message: 'Please specify at least one $DeviceFrame.',
                ),
              );
            },
          );

          test(
            'supportedLocales is empty',
            () {
              expect(
                () => Widgetbook(
                  categories: categories,
                  appInfo: appInfo,
                  themes: themes,
                  supportedLocales: const [],
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
