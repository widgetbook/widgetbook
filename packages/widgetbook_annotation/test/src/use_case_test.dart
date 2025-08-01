// ignore_for_file: deprecated_member_use_from_same_package

import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:widgetbook_annotation/src/use_case.dart';

void main() {
  group('$UseCase', () {
    test('creates type-instance', () {
      final instance = UseCase(name: 'Test', type: int);

      expect(instance.name, equals('Test'));
      expect(instance.type, equals(int));
      expect(instance.component, equals('$int'));
    });
  });

  test('creates component-instance', () {
    final instance = UseCase(name: 'Test', component: '$int');

    expect(instance.name, equals('Test'));
    expect(instance.type, isNull);
    expect(instance.component, equals('$int'));
  });

  test('throws when both type and component are specified', () {
    expect(
      () => UseCase(name: 'Test', type: int, component: '$int'),
      throwsA(isA<AssertionError>()),
    );
  });

  test('throws when neither type nor component is specified', () {
    expect(
      () => UseCase(name: 'Test'),
      throwsA(isA<AssertionError>()),
    );
  });
}
