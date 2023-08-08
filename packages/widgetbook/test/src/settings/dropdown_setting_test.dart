import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:widgetbook/src/settings/settings.dart';

import '../../helper/helper.dart';

void main() {
  group(
    '$DropdownSetting',
    () {
      testWidgets(
        'given a callback, '
        'when an option is selected, '
        'then the callback is invoked',
        (tester) async {
          const options = ['A', 'B'];
          final callback = VoidFn1Mock<String>();

          await tester.pumpWidgetWithMaterialApp(
            DropdownSetting(
              options: options,
              onSelected: callback.call,
            ),
          );

          await tester.findAndTap(
            find.byType(DropdownSetting<String>),
          );

          await tester.findAndTap(
            find.text(options.last).last,
          );

          verify(() => callback.call(options.last)).called(1);
        },
      );
    },
  );
}
