import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:widgetbook/src/navigation/navigation.dart';

import '../../../helper/helper.dart';

void main() {
  group(
    '$SearchField',
    () {
      testWidgets(
        'given no initial value, '
        'then clear button is not visible',
        (tester) async {
          await tester.pumpWidgetWithMaterialApp(
            const SearchField(),
          );

          expect(
            find.byIcon(Icons.close),
            findsNothing,
          );
        },
      );

      testWidgets(
        'given an initial value, '
        'then clear button is not visible',
        (tester) async {
          await tester.pumpWidgetWithMaterialApp(
            const SearchField(
              value: 'Widgetbook',
            ),
          );

          expect(
            find.byIcon(Icons.close),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'when clear button is tapped, '
        'then text is cleared',
        (tester) async {
          await tester.pumpWidgetWithMaterialApp(
            const SearchField(
              value: 'Search Value',
            ),
          );

          await tester.findAndTap(
            find.byIcon(Icons.close),
          );

          final textField = tester.widget<TextFormField>(
            find.byType(TextFormField),
          );

          expect(
            textField.controller?.text,
            isEmpty,
          );
        },
      );

      testWidgets(
        'when clear button is tapped, '
        'then onCleared is called',
        (tester) async {
          final onCleared = VoidFnMock();

          await tester.pumpWidgetWithMaterialApp(
            SearchField(
              value: 'Search Value',
              onCleared: onCleared.call,
            ),
          );

          await tester.findAndTap(find.byIcon(Icons.close));

          verify(
            () => onCleared.call(),
          ).called(1);
        },
      );

      testWidgets(
        'when text is changed, '
        'then onChanged is called',
        (tester) async {
          final onChanged = VoidFn1Mock<String>();

          await tester.pumpWidgetWithMaterialApp(
            SearchField(
              onChanged: onChanged.call,
            ),
          );

          final text = 'Widgetbook';
          await tester.enterText(find.byType(TextFormField), text);

          verify(
            () => onChanged.call(text),
          ).called(1);
        },
      );
    },
  );
}
