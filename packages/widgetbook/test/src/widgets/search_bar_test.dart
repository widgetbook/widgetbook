import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:widgetbook/src/widgets/search_bar.dart';

import '../../helper/widget_test_helper.dart';
import '../../mocks/providers/organizer_provider_mock.dart';

Finder _findTextField() {
  final textFieldFinder = find.byKey(
    Key(
      '$SearchBar.$TextField',
    ),
  );
  expect(textFieldFinder, findsOneWidget);
  return textFieldFinder;
}

Finder _findCancelButton() {
  final cancelSearchButton = find.byKey(
    Key('$SearchBar.CancelSearchButton'),
  );

  expect(cancelSearchButton, findsOneWidget);
  return cancelSearchButton;
}

void _expectNoCancelButton() {
  final cancelSearchButton = find.byKey(
    Key('$SearchBar.CancelSearchButton'),
  );

  expect(cancelSearchButton, findsNothing);
}

void _expectEmptyTextField(String previousValue) {
  final textFinder = find.text(previousValue);
  expect(textFinder, findsNothing);
}

void main() {
  group(
    '$SearchBar',
    () {
      // TODO rename test
      testWidgets(
        'behaves correctly',
        (WidgetTester tester) async {
          final organizerProvider = OrganizerProviderMock();
          await tester.pumpWidgetWithMaterialApp(
            SearchBar(
              theme: ThemeMode.dark,
              organizerProvider: organizerProvider,
            ),
          );

          _expectNoCancelButton();

          const searchTerm = 'Test';
          final textFieldFinder = _findTextField();

          await tester.enterText(
            textFieldFinder,
            searchTerm,
          );
          await tester.pump();

          verify(
            () => organizerProvider.filter(searchTerm),
          ).called(1);

          final cancelSearchButton = _findCancelButton();

          await tester.tap(cancelSearchButton);
          await tester.pump();

          verify(
            organizerProvider.resetFilter,
          ).called(1);

          _expectNoCancelButton();
          _expectEmptyTextField(searchTerm);
        },
      );
    },
  );
}
