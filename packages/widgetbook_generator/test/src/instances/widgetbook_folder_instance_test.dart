import 'package:test/test.dart';
import 'package:widgetbook_generator/instances/list_instance.dart';
import 'package:widgetbook_generator/instances/property.dart';
import 'package:widgetbook_generator/instances/widgetbook_component_instance.dart';
import 'package:widgetbook_generator/instances/widgetbook_folder_instance.dart';
import 'package:widgetbook_generator/models/element_metadata.dart';
import 'package:widgetbook_generator/models/use_case_metadata.dart';
import 'package:widgetbook_generator/tree/tree_node.dart';

import 'instance_helper.dart';

void main() {
  group(
    '$WidgetbookFolderInstance',
    () {
      final useCase = UseCaseMetadata(
        functionName: '',
        designLink: null,
        name: 'UseCase',
        importUri: 'package:widgetbook/src/widgets/component.usecase.dart',
        filePath: 'lib/src/widgets/component.usecase.dart',
        component: ElementMetadata(
          name: 'Component',
          importUri: 'package:widgetbook/src/widgets/component.dart',
          filePath: 'lib/src/widgets/component.dart',
        ),
      );

      final folder1 = TreeNode<String>('Folder1');
      final folder2 = TreeNode<String>('Folder2');
      final component = TreeNode<String>('Component', {
        'UseCase': TreeNode<UseCaseMetadata>(useCase),
      });

      final root = TreeNode<String>('root', {
        'Folder1': folder1,
        'Folder2': folder2,
        'Component': component,
      });

      final instance = WidgetbookFolderInstance(
        node: root,
      );

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
                  value: 'root',
                ),
                Property(
                  key: 'children',
                  instance: ListInstance(
                    instances: [
                      WidgetbookFolderInstance(node: folder1),
                      WidgetbookFolderInstance(node: folder2),
                      WidgetbookComponentInstance(
                        name: 'Component',
                        useCases: [useCase],
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
