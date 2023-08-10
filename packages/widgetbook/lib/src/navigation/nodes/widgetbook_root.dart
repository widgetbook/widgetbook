import 'tree_node.dart';

class WidgetbookRoot extends TreeNode {
  WidgetbookRoot({
    required super.children,
  }) : super(
          name: '',
          isInitiallyExpanded: true,
        );

  @override
  WidgetbookRoot copyWith({
    String? name,
    List<TreeNode>? children,
  }) {
    return WidgetbookRoot(
      children: children ?? this.children,
    );
  }
}
