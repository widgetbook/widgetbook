import 'tree_node.dart';

class WidgetbookPackage extends TreeNode {
  WidgetbookPackage({
    required super.name,
    required super.children,
    this.isInitiallyExpanded = true,
  });

  final bool isInitiallyExpanded;
}
