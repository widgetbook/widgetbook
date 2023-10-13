import 'package:code_builder/code_builder.dart';

import '../tree/tree_node.dart';
import 'widgetbook_instance.dart';

/// [InvokeExpression] for [WidgetbookFolder]
class WidgetbookCategoryInstance extends WidgetbookInstance {
  WidgetbookCategoryInstance({
    required TreeNode<String> node,
  }) : super(
          type: 'WidgetbookCategory',
          args: {
            'name': literalString(_parseCategoryName(node.data)),
            'children': literalList(
              node.instances,
            ),
          },
        );

  static String _parseCategoryName(String name) {
    final nameRegex = RegExp(r'^\[(.*?)\]$');
    final match = nameRegex.firstMatch(name);

    if (match == null) return name;

    return match.group(1)!;
  }
}
