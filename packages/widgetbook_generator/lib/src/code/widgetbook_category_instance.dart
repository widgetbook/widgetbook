import 'package:code_builder/code_builder.dart';

import '../tree/tree_node.dart';
import 'widgetbook_instance.dart';

/// [InvokeExpression] for `WidgetbookCategory`
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
    if (name.startsWith('[') && name.endsWith(']')) {
      return name.substring(1, name.length - 1);
    }

    return name;
  }
}
