import 'tree_node.dart';

class WidgetbookCategory extends TreeNode {
  WidgetbookCategory({
    required super.name,
    required super.children,
    this.isInitiallyExpanded = true,
  });

  final bool isInitiallyExpanded;
}
