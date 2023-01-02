import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/navigation/models/models.dart';

void main() {
  group(
    '$WidgetbookUseCase',
    () {
      test('Supports value equality', () {
        final useCase1 = WidgetbookUseCase(
          name: 'Use case',
          builder: (_) => const Center(),
        );
        final useCase2 = WidgetbookUseCase(
          name: 'Use case',
          builder: (_) => const Center(),
        );

        expect(useCase1, equals(useCase2));
      });
    },
    // Todo(Roaa94): make this test work
    // Currently it's not working because the
    // builder param equality doesn't work
    skip: true,
  );
}
