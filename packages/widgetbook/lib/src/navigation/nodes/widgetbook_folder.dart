import 'tree_node.dart';

class WidgetbookFolder extends TreeNode {
  WidgetbookFolder({
    required super.name,
    required super.children,
    this.isInitiallyExpanded = true,
  });

  final bool isInitiallyExpanded;
}
