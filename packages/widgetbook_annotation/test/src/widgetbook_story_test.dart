import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:widgetbook_annotation/src/widgetbook_use_case.dart';

void main() {
  group('$WidgetbookUseCase', () {
    test('creates instance', () {
      const instance = WidgetbookUseCase(name: 'Test', type: int);

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
