import 'package:test/test.dart';
import 'package:widgetbook_generator/generators/tree_service.dart';
import 'package:widgetbook_generator/instances/list_instance.dart';
import 'package:widgetbook_generator/instances/property.dart';
import 'package:widgetbook_generator/instances/widgetbook_folder_instance.dart';
import 'package:widgetbook_generator/instances/widgetbook_widget_instance.dart';

import 'instance_helper.dart';

void main() {
  group(
    '$WidgetbookFolderInstance',
    () {
      final folder = Folder('Folder');
      final folder1 = Folder('Folder1');
      final folder2 = Folder('Folder2');
      final widget1 = Widget('Widget1');
      final widget2 = Widget('Widget2');
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

      final instance = WidgetbookFolderInstance(folder: folder);

      testName('WidgetbookFolder', instance: instance);

      test(
        '.properties returns a StringProperty and Property containing a list',
        () {
          expect(
            instance.properties,
            equals(
              [
                Property.string(
                  key: 'name',
                  value: folder.name,
                ),
                Property(
                  key: 'children',
                  instance: ListInstance(
                    instances: [
                      // Somehow the order of instances injected are in a
                      // reversed order. Since the order doesn't really matter
                      // the test has been left like this
                      WidgetbookComponentInstance(
                        name: widget2.name,
                        stories: widget2.stories,
                        isExpanded: true,
                      ),
                      WidgetbookComponentInstance(
                        name: widget1.name,
                        stories: widget1.stories,
                      ),
                      WidgetbookFolderInstance(folder: folder1),
                      WidgetbookFolderInstance(folder: folder2),
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
