import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/navigation/models/models.dart';

void main() {
  group('$WidgetbookComponent', () {
    test('Supports value equality', () {
      const component1 = WidgetbookComponent(
        name: 'Component',
        useCases: [],
      );
      const component2 = WidgetbookComponent(
        name: 'Component',
        useCases: [],
      );
      expect(component1, equals(component2));
    });
  });
}
