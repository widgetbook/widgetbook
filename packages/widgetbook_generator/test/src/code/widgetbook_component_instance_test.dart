import 'package:test/test.dart';
import 'package:widgetbook_generator/code/widgetbook_component_instance.dart';
import 'package:widgetbook_generator/models/use_case_metadata.dart';
import 'package:widgetbook_generator/tree/tree_node.dart';

import '../../helpers/code.dart';
import '../../helpers/mock_use_case_metadata.dart';

void main() {
  group('$WidgetbookComponentInstance', () {
    test('empty use cases', () {
      final actual = WidgetbookComponentInstance(
        node: TreeNode<String>('Component'),
        baseDir: '/',
      );

      expectExpression(
        actual,
        '''
          WidgetbookComponent(
            name: 'Component',
            useCases: [],
          )
        ''',
      );
    });

    test('with use cases', () {
      final useCase = MockUseCaseMetadata();
      final actual = WidgetbookComponentInstance(
        node: TreeNode<String>(
          'Component',
          {'Default': TreeNode<UseCaseMetadata>(useCase)},
        ),
        baseDir: '/',
      );

      expectExpression(
        actual,
        '''
          WidgetbookComponent(
            name: 'Component',
            useCases: [
              WidgetbookUseCase(
                name: 'Default',
                builder: defaultUseCase,
              )
            ],
          )
        ''',
      );
    });
  });
}
