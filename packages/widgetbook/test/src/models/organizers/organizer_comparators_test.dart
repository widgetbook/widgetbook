import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/models/models.dart';
import 'package:widgetbook/src/models/organizers/organizer_comparators.dart';

void main() {
  group('byNameAsc', () {
    test('sorts by name ascending', () {
      final comparator = OrganizerComparators.byNameAsc;
      final actual = comparator(
        WidgetbookComponent(name: 'A', useCases: []),
        WidgetbookComponent(name: 'B', useCases: []),
      );

      expect(actual, -1);
    });

    test('sorts by name ascending given two organizers with equal names', () {
      final comparator = OrganizerComparators.byNameAsc;
      final actual = comparator(
        WidgetbookComponent(name: 'A', useCases: []),
        WidgetbookComponent(name: 'A', useCases: []),
      );

      expect(actual, 0);
    });
  });

  group('byNameDesc', () {
    test('sorts by name descending', () {
      final comparator = OrganizerComparators.byNameDesc;
      final actual = comparator(
        WidgetbookComponent(name: 'A', useCases: []),
        WidgetbookComponent(name: 'B', useCases: []),
      );

      expect(actual, 1);
    });

    test('sorts by name descending given two organizers with equal names', () {
      final comparator = OrganizerComparators.byNameAsc;
      final actual = comparator(
        WidgetbookComponent(name: 'A', useCases: []),
        WidgetbookComponent(name: 'A', useCases: []),
      );

      expect(actual, 0);
    });
  });
}
