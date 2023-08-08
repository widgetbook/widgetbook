import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/tester_extension.dart';

void main() {
  group(
    '$LocalizationAddon',
    () {
      const locale = Locale('de');
      final addon = LocalizationAddon(
        locales: [
          const Locale('en'),
          const Locale('de'),
          const Locale('ar'),
        ],
        localizationsDelegates: [
          DefaultWidgetsLocalizations.delegate,
        ],
      );

      test(
        'given a query group, '
        'then [valueFromQueryGroup] can parse the value',
        () {
          final result = addon.valueFromQueryGroup({
            'name': locale.toLanguageTag(),
          });

          expect(result, equals(locale));
        },
      );

      testWidgets(
        'given German Locale setting, '
        'then [buildUseCase] wraps child with [Localizations] widget',
        (tester) async {
          await tester.pumpWidgetWithBuilder(
            (context) => addon.buildUseCase(
              context,
              const Text('child'),
              locale,
            ),
          );

          final result = Localizations.localeOf(
            tester.element(find.text('child')),
          );

          expect(result, equals(locale));
        },
      );
    },
  );
}
