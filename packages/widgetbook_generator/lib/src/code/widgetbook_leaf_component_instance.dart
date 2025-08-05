import 'package:code_builder/code_builder.dart';

import '../models/use_case_metadata.dart';
import '../tree/tree_node.dart';
import 'widgetbook_instance.dart';
import 'widgetbook_use_case_instance.dart';

/// [InvokeExpression] for [WidgetbookLeafComponent]
class WidgetbookLeafComponentInstance extends WidgetbookInstance {
  WidgetbookLeafComponentInstance({
    required TreeNode<String> node,
  }) : super(
         type: 'WidgetbookLeafComponent',
         args: {
           'name': literalString(node.data),
           'useCase': WidgetbookUseCaseInstance(
             useCase: node.children.values.first.data as UseCaseMetadata,
           ),
         },
       );
}
