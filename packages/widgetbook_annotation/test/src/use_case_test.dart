import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:widgetbook_annotation/src/use_case.dart';

void main() {
  group('$UseCase', () {
    test('creates instance', () {
      const instance = UseCase(name: 'Test', type: int);

      expect(
        instance.name,
        equals('Test'),
      );
      expect(
        instance.type,
        equals(int),
      );
    });
  });
}
