import 'package:test/test.dart';
import 'package:widgetbook_generator/widgetbook_generator.dart';

import '../../helpers/code.dart';
import '../../helpers/mock_use_case_metadata.dart';

void main() {
  group('$WidgetbookFolderInstance', () {
    test('empty children', () {
      final actual = WidgetbookFolderInstance(
        node: TreeNode<String>('folder'),
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
      final actual = WidgetbookFolderInstance(
        node: TreeNode<String>('root', {
          'Folder1': TreeNode<String>('Folder1'),
          'Folder2': TreeNode<String>('Folder2'),
          'Component': TreeNode<String>('Component', {
            'Default': TreeNode<UseCaseMetadata>(
              MockUseCaseMetadata(),
            ),
          }),
        }),
      );

      expectExpression(
        actual,
        '''
          WidgetbookFolder(
            name: 'root',
            children: [
              WidgetbookComponent(
                name: 'Component',
                useCases: [
                  WidgetbookUseCase(
                    name: 'Default',
                    builder: defaultUseCase,
                  )
                ],
              ),
              WidgetbookFolder(
                name: 'Folder1',
                children: [],
              ),
              WidgetbookFolder(
                name: 'Folder2',
                children: [],
              ),
            ],
          )
        ''',
      );
    });
  });
}
