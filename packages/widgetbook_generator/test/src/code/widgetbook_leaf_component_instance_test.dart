import 'package:test/test.dart';
import 'package:widgetbook_generator/widgetbook_generator.dart';

import '../../helpers/code.dart';
import '../../helpers/mock_use_case_metadata.dart';

void main() {
  group('$WidgetbookLeafComponentInstance', () {
    test('with use case', () {
      final actual = WidgetbookLeafComponentInstance(
        node: TreeNode<String>('LeafComponent', {
          'Default': TreeNode<UseCaseMetadata>(
            MockUseCaseMetadata(),
          ),
        }),
      );

      expectExpression(
        actual,
        '''
          WidgetbookLeafComponent(
            name: 'LeafComponent',
            useCase: WidgetbookUseCase(
              name: 'Default',
              builder: defaultUseCase,
            ),
          )
        ''',
      );
    });
  });
}
