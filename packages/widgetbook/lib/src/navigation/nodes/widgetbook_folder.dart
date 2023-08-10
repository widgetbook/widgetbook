import 'tree_node.dart';

class WidgetbookFolder extends TreeNode {
  WidgetbookFolder({
    required super.name,
    required super.children,
    this.isInitiallyExpanded = true,
  });

  final bool isInitiallyExpanded;

  @override
  WidgetbookFolder copyWith({
    String? name,
    List<TreeNode>? children,
  }) {
    return WidgetbookFolder(
      name: name ?? this.name,
      children: children ?? this.children,
      isInitiallyExpanded: isInitiallyExpanded,
    );
  }
}
