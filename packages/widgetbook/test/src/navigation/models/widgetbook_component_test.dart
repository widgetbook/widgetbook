import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/navigation/models/models.dart';

void main() {
  group('$WidgetbookComponent', () {
    test('Supports value equality', () {
      final component1 = WidgetbookComponent(
        name: 'Component',
        useCases: [],
      );
      final component2 = WidgetbookComponent(
        name: 'Component',
        useCases: [],
      );
      expect(component1, equals(component2));
    });
  });
}
