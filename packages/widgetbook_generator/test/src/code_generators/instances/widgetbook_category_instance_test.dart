import 'package:test/test.dart';
import 'package:widgetbook_generator/code_generators/instances/list_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/widgetbook_category_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/widgetbook_folder_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/widgetbook_widget_instance.dart';
import 'package:widgetbook_generator/code_generators/properties/property.dart';
import 'package:widgetbook_generator/services/tree_service.dart';

import '../instance_helper.dart';

void main() {
  group(
    '$WidgetbookCategoryInstance',
    () {
      final folder = Folder(name: 'Folder');
      final folder1 = Folder(
        name: 'Folder1',
      );
      final folder2 = Folder(
        name: 'Folder2',
      );
      final folders = [
        folder1,
        folder2,
      ];

      final widget1 = Widget('Widget1');
      final widget2 = Widget('Widget2');
      final widgets = [
        widget1,
        widget2,
      ];

      folder.subFolders
        ..putIfAbsent(
          folder1.name,
          () => folder1,
        )
        ..putIfAbsent(
          folder2.name,
          () => folder2,
        );

      folder.widgets
        ..putIfAbsent(widget1.name, () => widget1)
        ..putIfAbsent(widget2.name, () => widget2);

      const categoryName = 'stories';

      testName(
        'WidgetbookCategory',
        instance: WidgetbookCategoryInstance(name: categoryName),
      );

      test(
        ".name returns 'stories'",
        () {
          final instance = WidgetbookCategoryInstance(
            name: categoryName,
            folders: folders,
            widgets: widgets,
          );
          expect(
            instance.properties,
            equals(
              [
                Property.string(key: 'name', value: categoryName),
                Property(
                  key: 'children',
                  instance: ListInstance(
                    instances: [
                      WidgetbookFolderInstance(folder: folder1),
                      WidgetbookFolderInstance(folder: folder2),
                      WidgetbookComponentInstance(
                        name: widget1.name,
                        stories: widget1.stories,
                      ),
                      WidgetbookComponentInstance(
                        name: widget2.name,
                        stories: widget2.stories,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
