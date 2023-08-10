import 'tree_node.dart';

class WidgetbookCategory extends TreeNode {
  WidgetbookCategory({
    required super.name,
    required super.children,
    super.isInitiallyExpanded,
  });

  @override
  WidgetbookCategory copyWith({
    String? name,
    List<TreeNode>? children,
  }) {
    return WidgetbookCategory(
      name: name ?? this.name,
      children: children ?? this.children,
      isInitiallyExpanded: isInitiallyExpanded,
    );
  }
}
