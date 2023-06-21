import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:widgetbook/src/navigation/navigation.dart';

import '../../../helper/callback_mock.dart';
import '../../../helper/widget_test_helper.dart';

void main() {
  group('$SearchField', () {
    testWidgets(
      'Clear search button is initially not rendered',
      (tester) async {
        await tester.pumpWidgetWithMaterialApp(
          const SearchField(),
        );

        final finder = find.byWidgetPredicate(
          (widget) => widget is Icon && widget.icon == Icons.close,
        );

        expect(finder, findsNothing);
      },
    );

    testWidgets(
      'Clear search button is shown after entering text in the text field',
      (tester) async {
        await tester.pumpWidgetWithMaterialApp(
          const SearchField(searchValue: 'Search Value'),
        );

        await tester.pumpAndSettle();

        final clearButtonFinder = find.byWidgetPredicate(
          (widget) => widget is Icon && widget.icon == Icons.close,
        );

        expect(clearButtonFinder, findsOneWidget);
      },
    );

    testWidgets(
      'Clicking on clear search button '
      'clears search value and removes the clear icon',
      (tester) async {
        await tester.pumpWidgetWithMaterialApp(
          const SearchField(
            searchValue: 'Search Value',
          ),
        );

        final textFieldFinder = find.byType(TextFormField);
        await tester.pumpAndSettle();

        final clearButtonFinder = find.byWidgetPredicate(
          (widget) => widget is Icon && widget.icon == Icons.close,
        );
        expect(clearButtonFinder, findsOneWidget);

        await tester.tap(clearButtonFinder);
        await tester.pumpAndSettle();

        final textFieldWidget = tester.widget(textFieldFinder) as TextFormField;
        expect(textFieldWidget.controller?.text, isEmpty);
      },
    );

    testWidgets(
      'onSearchPressed is executed',
      (tester) async {
        final voidCallbackMock = VoidCallbackMock();
        await tester.pumpWidgetWithMaterialApp(
          SearchField(
            onSearchPressed: voidCallbackMock.call,
          ),
        );
        final searchButtonFinder = find.byWidgetPredicate(
          (widget) => widget is Icon && widget.icon == Icons.search,
        );

        await tester.tap(searchButtonFinder);
        verify(voidCallbackMock.call).called(1);
      },
    );
  });
}
