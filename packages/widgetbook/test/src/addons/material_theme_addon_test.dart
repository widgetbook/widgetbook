import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/helper.dart';

void main() {
  group(
    '$MaterialThemeAddon',
    () {
      final blueTheme = WidgetbookTheme<ThemeData>(
        name: 'Blue Theme',
        data: ThemeData(
          primaryColor: Colors.blue,
        ),
      );

      final yellowTheme = WidgetbookTheme<ThemeData>(
        name: 'Yellow Theme',
        data: ThemeData(
          primaryColor: Colors.yellow,
        ),
      );

      final addon = MaterialThemeAddon(
        themes: [
          blueTheme,
          yellowTheme,
        ],
      );

      testWidgets(
        'given theme setting, '
        'then [buildUseCase] wraps child with [Theme] widget',
        (tester) async {
          await tester.pumpWidgetWithBuilder(
            (context) => addon.buildUseCase(
              context,
              const Text('child'),
              yellowTheme,
            ),
          );

          final result = Theme.of(
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
