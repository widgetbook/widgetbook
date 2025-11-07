import 'package:code_builder/code_builder.dart';

import '../tree/tree_node.dart';
import 'widgetbook_instance.dart';

/// [InvokeExpression] for `WidgetbookComponent`
class WidgetbookComponentInstance extends WidgetbookInstance {
  WidgetbookComponentInstance({
    required TreeNode<String> node,
  }) : super(
         type: 'WidgetbookComponent',
         args: {
           'name': literalString(node.data),
           'useCases': literalList(
             node.instances,
           ),
         },
       );
}
