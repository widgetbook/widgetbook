import 'package:test/test.dart';
import 'package:widgetbook_generator/code/widgetbook_folder_instance.dart';
import 'package:widgetbook_generator/models/use_case_metadata.dart';
import 'package:widgetbook_generator/tree/tree_node.dart';

import '../../helpers/code.dart';
import '../../helpers/mock_use_case_metadata.dart';

void main() {
  group('$WidgetbookFolderInstance', () {
    test('empty children', () {
      final actual = WidgetbookFolderInstance(
        node: TreeNode<String>('folder'),
        baseDir: '/',
      );

      expectExpression(
        actual,
        '''
          WidgetbookFolder(
            name: 'folder',
            children: [],
          )
        ''',
      );
    });

    test('with children', () {
      final useCase = MockUseCaseMetadata();
      final root = TreeNode<String>('root', {
        'Folder1': TreeNode<String>('Folder1'),
        'Folder2': TreeNode<String>('Folder2'),
        'Component': TreeNode<String>('Component', {
          'Default': TreeNode<UseCaseMetadata>(useCase),
        }),
      });

      final actual = WidgetbookFolderInstance(
        node: root,
        baseDir: '/',
      );

      expectExpression(
        actual,
        '''
          WidgetbookFolder(
            name: 'root',
            children: [
              WidgetbookFolder(
                name: 'Folder1',
                children: [],
              ),
              WidgetbookFolder(
                name: 'Folder2',
                children: [],
              ),
              WidgetbookComponent(
                name: 'Component',
                useCases: [
                  WidgetbookUseCase(
                    name: 'Default',
                    builder: defaultUseCase,
                  )
                ],
              ),
            ],
          )
        ''',
      );
    });
  });
}
