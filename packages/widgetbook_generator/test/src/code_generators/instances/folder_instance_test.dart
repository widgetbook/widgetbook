import 'package:test/test.dart';
import 'package:widgetbook_generator/code_generators/instances/folder_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/list_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/widget_element_instance.dart';
import 'package:widgetbook_generator/code_generators/properties/property.dart';
import 'package:widgetbook_generator/services/tree_service.dart';

import '../instance_helper.dart';

void main() {
  group(
    '$FolderInstance',
    () {
      final folder = Folder(name: 'Folder');
      final folder1 = Folder(
        name: 'Folder1',
      );
      final folder2 = Folder(
        name: 'Folder2',
      );
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

      final instance = FolderInstance(folder: folder);

      testName('Folder', instance: instance);

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
                  key: 'widgets',
                  instance: ListInstance(
                    instances: [
                      // Somehow the order of instances injected are in a
                      // reversed order. Since the order doesn't really matter
                      // the test has been left like this
                      WidgetElementInstance(
                        name: widget2.name,
                        stories: widget2.stories,
                      ),
                      WidgetElementInstance(
                        name: widget1.name,
                        stories: widget1.stories,
                      ),
                    ],
                  ),
                ),
                Property(
                  key: 'folders',
                  instance: ListInstance(
                    instances: [
                      FolderInstance(folder: folder1),
                      FolderInstance(folder: folder2),
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
