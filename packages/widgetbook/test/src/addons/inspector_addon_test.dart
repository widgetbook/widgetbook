import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inspector/inspector.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/helper.dart';

void main() {
  group('InspectorAddon', () {
    final addon = InspectorAddon();

    test('initial setting is false', () {
      expect(addon.enabled, isFalse);
    });

    test('fields contain isEnabled BooleanField with initial value false', () {
      final field = addon.fields.singleWhere(
        (element) => element.name == 'isEnabled',
        orElse: () => throw Exception('Field not found'),
      );

      expect(field, isA<BooleanField>());
      expect((field as BooleanField).initialValue, isFalse);
    });

    test('valueFromQueryGroup returns correct value', () {
      final group = {'isEnabled': 'true'};
      final result = addon.valueFromQueryGroup(group);
      expect(result, isTrue);
    });

    testWidgets('buildUseCase with isEnabled true wraps child with Inspector', (
      tester,
    ) async {
      await tester.pumpWidgetWithBuilder(
        (context) => addon.buildUseCase(context, const Text('Test'), true),
      );

      expect(find.byType(Inspector), findsOneWidget);
      expect(find.text('Test'), findsOneWidget);
    });

    testWidgets(
      'buildUseCase with isEnabled true has Inspector with isEnabled true',
      (tester) async {
        await tester.pumpWidgetWithBuilder(
          (context) => addon.buildUseCase(context, const Text('Test'), true),
        );

        final inspectorFinder = find.byType(Inspector);
        expect(inspectorFinder, findsOneWidget);
        final inspector = tester.firstWidget(inspectorFinder) as Inspector;
        expect(inspector.isEnabled, true);
      },
    );

    testWidgets('buildUseCase with isEnabled false returns child directly', (
      tester,
    ) async {
      await tester.pumpWidgetWithBuilder(
        (context) => addon.buildUseCase(context, const Text('Test'), false),
      );

      expect(find.byType(Inspector), findsNothing);
      expect(find.text('Test'), findsOneWidget);
    });
  });
}
