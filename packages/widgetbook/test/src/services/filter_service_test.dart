import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/models/models.dart';
import 'package:widgetbook/src/services/filter_service.dart';

void main() {
  final story1 = WidgetbookUseCase(
    name: 'Story 1',
    builder: (context) => Container(),
  );

  final story2 = WidgetbookUseCase(
    name: 'Story 2',
    builder: (context) => Container(),
  );

  group(
    '$FilterService',
    () {
      test(
        'filters $WidgetbookComponent',
        () async {
          final widget1 = WidgetbookComponent(
            name: 'Widget 1',
            isExpanded: true,
            useCases: [
              story1,
              story2,
            ],
          );

          final widget2 = WidgetbookComponent(
            name: 'Widget 2',
            isExpanded: true,
            useCases: [
              story1,
              story2,
            ],
          );

          final category = WidgetbookCategory(
            name: 'Category 1',
            folders: [
              WidgetbookFolder(
                name: 'Folder 1',
              ),
            ],
            widgets: [
              widget1,
              widget2,
            ],
          );

          final searchTerm = widget1.name;

          const service = FilterService();
          final result = service.filter(
            searchTerm,
            [
              category,
            ],
          );

          expect(
            result,
            equals(
              [
                WidgetbookCategory(
                  name: 'Category 1',
                  folders: [],
                  widgets: [
                    widget1,
                  ],
                ),
              ],
            ),
          );
        },
      );

      test(
        'filters $WidgetbookFolder',
        () async {
          final folder1_1 = WidgetbookFolder(name: 'Folder1.1');
          final folder1_2 = WidgetbookFolder(name: 'Folder1.2');
          final folder1 = WidgetbookFolder(
            name: 'Folder 1',
            folders: [
              folder1_1,
              folder1_2,
            ],
          );
          final folder2 = WidgetbookFolder(name: 'Folder 2');

          final widget1 = WidgetbookComponent(
            name: 'Widget 1',
            isExpanded: true,
            useCases: [
              story1,
              story2,
            ],
          );

          final category = WidgetbookCategory(
            name: 'Category 1',
            folders: [
              folder1,
              folder2,
            ],
            widgets: [
              widget1,
            ],
          );

          final searchTerm = folder1_1.name;

          const service = FilterService();
          final result = service.filter(
            searchTerm,
            [
              category,
            ],
          );

          expect(
            result,
            equals(
              [
                WidgetbookCategory(
                  name: 'Category 1',
                  folders: [
                    WidgetbookFolder(
                      name: 'Folder 1',
                      folders: [
                        folder1_1,
                      ],
                    ),
                  ],
                  widgets: [],
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
