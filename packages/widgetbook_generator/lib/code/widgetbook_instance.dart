import 'package:code_builder/code_builder.dart';

import '../models/use_case_metadata.dart';
import '../tree/tree_node.dart';
import 'refer.dart';
import 'widgetbook_component_instance.dart';
import 'widgetbook_folder_instance.dart';
import 'widgetbook_use_case_instance.dart';

class WidgetbookInstance extends InvokeExpression {
  WidgetbookInstance({
    required String type,
    required Map<String, Expression> args,
    required String baseDir,
  }) : super.newOf(
          referWidgetbook(type),
          [],
          args,
        );

  factory WidgetbookInstance.fromNode(
    TreeNode node,
    String baseDir,
  ) {
    if (node.data is UseCaseMetadata) {
      return WidgetbookUseCaseInstance(
        useCase: node.data as UseCaseMetadata,
        baseDir: baseDir,
      );
    }

    final children = node.children.values;
    final isComponentNode = children.isNotEmpty &&
        children.every(
          (child) => child is TreeNode<UseCaseMetadata>,
        );

    return isComponentNode
        ? WidgetbookComponentInstance(
            node: node as TreeNode<String>,
            baseDir: baseDir,
          )
        : WidgetbookFolderInstance(
            node: node as TreeNode<String>,
            baseDir: baseDir,
          );
  }
}
