import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:widgetbook/src/settings/settings.dart';

import '../../helper/callback_mock.dart';
import '../../helper/widget_test_helper.dart';

void main() {
  group(
    '$DropdownSetting',
    () {
      testWidgets(
        'callback is invoked',
        (tester) async {
          final valueChangedCallbackMock = ValueChangedCallbackMock<String>();
          await tester.pumpWidgetWithMaterialApp(
            DropdownSetting<String>(
              options: const ['A', 'B'],
              onSelected: valueChangedCallbackMock.call,
            ),
          );

          final dropdown = find.byType(DropdownSetting<String>);

          await tester.tap(dropdown);
          await tester.pumpAndSettle();

          final dropdownItem = find.text('B').last;

          await tester.tap(dropdownItem);
          await tester.pumpAndSettle();

          verify(() => valueChangedCallbackMock.call('B')).called(1);
        },
      );
    },
  );
}
