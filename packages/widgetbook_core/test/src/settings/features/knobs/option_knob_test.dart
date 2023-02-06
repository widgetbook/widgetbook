import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

import '../../../../helper/callback_mock.dart';
import '../../../../helper/widget_tester_extension.dart';

void main() {
  group(
    '$OptionKnob',
    () {
      const values = ['A', 'B'];
      testWidgets(
        'invokes onChanged',
        (tester) async {
          final valueChangedCallbackMock = ValueChangedCallbackMock<String>();

          await tester.pumpWidgetWithMaterial(
            child: OptionKnob(
              name: '$OptionKnob',
              values: values,
              value: values.first,
              onChanged: valueChangedCallbackMock,
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
