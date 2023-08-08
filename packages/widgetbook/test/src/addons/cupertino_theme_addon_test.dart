import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/helper.dart';

void main() {
  group(
    '$CupertinoThemeAddon',
    () {
      const blueTheme = WidgetbookTheme<CupertinoThemeData>(
        name: 'Blue Theme',
        data: CupertinoThemeData(
          primaryColor: Colors.blue,
        ),
      );

      const yellowTheme = WidgetbookTheme<CupertinoThemeData>(
        name: 'Yellow Theme',
        data: CupertinoThemeData(
          primaryColor: Colors.yellow,
        ),
      );

      final addon = CupertinoThemeAddon(
        themes: [
          blueTheme,
          yellowTheme,
        ],
      );

      testWidgets(
        'given theme setting, '
        'then [buildUseCase] wraps child with [CupertinoTheme] widget',
        (tester) async {
          await tester.pumpWidgetWithBuilder(
            (context) => addon.buildUseCase(
              context,
              const Text('child'),
              yellowTheme,
            ),
          );

          final result = CupertinoTheme.of(
            tester.element(find.text('child')),
          );

          expect(
            result.primaryColor,
            equals(yellowTheme.data.primaryColor),
          );
        },
      );
    },
  );
}
