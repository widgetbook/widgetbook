import 'package:test/test.dart';
import 'package:widgetbook_generator/widgetbook_generator.dart';

import '../../helpers/code.dart';

void main() {
  group('$WidgetbookCategoryInstance', () {
    test('names without brackets', () {
      final actual = WidgetbookCategoryInstance(
        node: TreeNode<String>('[category]'),
      );

      expectExpression(
        actual,
        '''
          WidgetbookCategory(
            name: 'category',
            children: [],
          )
        ''',
      );
    });
  });
}
