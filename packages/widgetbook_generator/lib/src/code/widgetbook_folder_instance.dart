import 'package:code_builder/code_builder.dart';

import '../tree/tree_node.dart';
import 'widgetbook_instance.dart';

/// [InvokeExpression] for `WidgetbookFolder`
class WidgetbookFolderInstance extends WidgetbookInstance {
  WidgetbookFolderInstance({
    required TreeNode<String> node,
  }) : super(
         type: 'WidgetbookFolder',
         args: {
           'name': literalString(node.data),
           'children': literalList(
             node.instances,
           ),
         },
       );
}
