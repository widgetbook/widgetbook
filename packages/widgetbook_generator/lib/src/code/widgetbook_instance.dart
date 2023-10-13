import 'package:code_builder/code_builder.dart';
import 'package:source_gen/source_gen.dart';

import '../models/use_case_metadata.dart';
import '../tree/tree_node.dart';
import 'refer.dart';
import 'widgetbook_category_instance.dart';
import 'widgetbook_component_instance.dart';
import 'widgetbook_folder_instance.dart';
import 'widgetbook_use_case_instance.dart';

class WidgetbookInstance extends InvokeExpression {
  WidgetbookInstance({
    required String type,
    required Map<String, Expression> args,
  }) : super.newOf(
          referWidgetbook(type),
          [],
          args,
        );

  factory WidgetbookInstance.fromNode(TreeNode node) {
    if (node.data is UseCaseMetadata) {
      return WidgetbookUseCaseInstance(
        useCase: node.data as UseCaseMetadata,
      );
    }

    final children = node.children.values;
    final isComponentNode = children.isNotEmpty &&
        children.every(
          (child) => child is TreeNode<UseCaseMetadata>,
        );

    if (isComponentNode) {
      return WidgetbookComponentInstance(node: node as TreeNode<String>);
    }

    if (node is! TreeNode<String>) {
      throw new InvalidGenerationSourceError(
        'Invalid state: node is not a ${TreeNode<String>}',
        todo: 'This is an issue within widgetbook_generator itself. '
            'Please open an issue at https://github.com/widgetbook/widgetbook/issues/new',
      );
    }

    final name = node.data;
    final categoryRegex = RegExp(r'^\[.*?\]$');
    final isCategory = categoryRegex.hasMatch(name);

    return isCategory
        ? WidgetbookCategoryInstance(node: node)
        : WidgetbookFolderInstance(node: node);
  }
}
