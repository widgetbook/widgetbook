import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/models/models.dart';
import 'package:widgetbook/src/services/filter_service.dart';

void main() {
  final story1 = Story(
    name: 'Story 1',
    builder: (context) => Container(),
  );

  final story2 = Story(
    name: 'Story 2',
    builder: (context) => Container(),
  );

  group(
    '$FilterService',
    () {
      test(
        'filters $WidgetElement',
        () async {
          final widget1 = WidgetElement(
            name: 'Widget 1',
            isExpanded: true,
            stories: [
              story1,
              story2,
            ],
          );

          final widget2 = WidgetElement(
            name: 'Widget 2',
            isExpanded: true,
            stories: [
              story1,
              story2,
            ],
          );

          final category = Category(
            name: 'Category 1',
            folders: [
              Folder(
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
                Category(
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
        'filters $Folder',
        () async {
          final folder1_1 = Folder(name: 'Folder1.1');
          final folder1_2 = Folder(name: 'Folder1.2');
          final folder1 = Folder(
            name: 'Folder 1',
            folders: [
              folder1_1,
              folder1_2,
            ],
          );
          final folder2 = Folder(name: 'Folder 2');

          final widget1 = WidgetElement(
            name: 'Widget 1',
            isExpanded: true,
            stories: [
              story1,
              story2,
            ],
          );

          final category = Category(
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
                Category(
                  name: 'Category 1',
                  folders: [
                    Folder(
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
