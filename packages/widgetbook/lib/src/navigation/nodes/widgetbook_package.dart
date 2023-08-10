import 'tree_node.dart';

class WidgetbookPackage extends TreeNode {
  WidgetbookPackage({
    required super.name,
    required super.children,
    this.isInitiallyExpanded = true,
  });

  final bool isInitiallyExpanded;

  @override
  WidgetbookPackage copyWith({
    String? name,
    List<TreeNode>? children,
  }) {
    return WidgetbookPackage(
      name: name ?? this.name,
      children: children ?? this.children,
      isInitiallyExpanded: isInitiallyExpanded,
    );
  }
}
