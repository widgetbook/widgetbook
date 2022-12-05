import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

import '../../../helper/callback_mock.dart';
import '../../../helper/widget_tester_extension.dart';

void main() {
  group(
    '$ExpanderButton',
    () {
      testWidgets(
        'onPressed is executed',
        (tester) async {
          final voidCallbackMock = VoidCallbackMock();
          await tester.pumpWidgetWithMaterial(
            child: ExpanderButton(
              onPressed: voidCallbackMock,
            ),
          );

          await tester.tap(find.byType(InkWell));
          verify(() => voidCallbackMock.call()).called(1);
        },
      );
    },
  );
}
