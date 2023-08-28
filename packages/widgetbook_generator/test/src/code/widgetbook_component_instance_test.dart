import 'package:test/test.dart';
import 'package:widgetbook_generator/widgetbook_generator.dart';

import '../../helpers/code.dart';
import '../../helpers/mock_use_case_metadata.dart';

void main() {
  group('$WidgetbookComponentInstance', () {
    test('empty use cases', () {
      final actual = WidgetbookComponentInstance(
        node: TreeNode<String>('Component'),
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
      final actual = WidgetbookComponentInstance(
        node: TreeNode<String>('Component', {
          'Default': TreeNode<UseCaseMetadata>(
            MockUseCaseMetadata(),
          ),
        }),
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
