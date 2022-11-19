import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/models/models.dart';
import 'package:widgetbook/src/models/organizers/organizer_comparators.dart';
import 'package:widgetbook/src/services/sort_service.dart';

void main() {
  late SortService service;

  setUp(() {
    service = const SortService();
  });

  group('sort()', () {
    test('recursively sorts categories in ascending order', () {
      final category1 = WidgetbookCategory(
        name: 'Category 1',
      );
      final category2 = WidgetbookCategory(
        name: 'Category 2',
      );

      final result = service.sort(
        [
          category2,
          category1,
        ],
        Sorting.asc,
      );

      expect(result, [
        category1,
        category2,
      ]);
    });
  });

  group('sortCategory()', () {
    test('returns a new instance', () {
      final tCategory = WidgetbookCategory(name: 'tCategory');
      final actual = service.sortCategory(
        tCategory,
        OrganizerComparators.byNameAsc,
      );

      expect(identical(actual, tCategory), isFalse);
    });

    test('recursively sorts category contents in ascending order', () {
      final tAFolder = WidgetbookFolder(name: 'aFolder');
      final tBFolder = WidgetbookFolder(name: 'bFolder');

      final tAWidget = WidgetbookComponent(name: 'aWidget', useCases: []);
      final tBWidget = WidgetbookComponent(name: 'bWidget', useCases: []);

      final tCategory = WidgetbookCategory(
        name: 'tCategory',
        folders: [tBFolder, tAFolder],
        widgets: [tBWidget, tAWidget],
      );

      final actual = service.sortCategory(
        tCategory,
        OrganizerComparators.byNameAsc,
      );

      expect(
        actual,
        WidgetbookCategory(
          name: 'tCategory',
          folders: [tAFolder, tBFolder],
          widgets: [tAWidget, tBWidget],
        ),
      );
    });
  });

  group('sortFolder()', () {
    test('returns a new instance', () {
      final tFolder = WidgetbookFolder(
        name: 'tFolder',
      );
      final actual = service.sortFolder(
        tFolder,
        OrganizerComparators.byNameAsc,
      );

      expect(identical(actual, tFolder), isFalse);
    });

    test('recursively sorts folder contents in ascending order', () {
      final tFolder = WidgetbookFolder(
        name: 'tFolder',
        folders: [
          WidgetbookFolder(name: 'bFolder'),
          WidgetbookFolder(name: 'aFolder'),
        ],
        widgets: [
          WidgetbookComponent(name: 'bWidget', useCases: []),
          WidgetbookComponent(name: 'aWidget', useCases: []),
        ],
      );

      final actual = service.sortFolder(
        tFolder,
        OrganizerComparators.byNameAsc,
      );

      expect(actual.folders.map((e) => e.name), ['aFolder', 'bFolder']);
      expect(actual.widgets.map((e) => e.name), ['aWidget', 'bWidget']);
    });
  });
}
