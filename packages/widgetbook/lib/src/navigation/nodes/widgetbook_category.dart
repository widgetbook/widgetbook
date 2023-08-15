import 'widgetbook_node.dart';

class WidgetbookCategory extends WidgetbookNode {
  WidgetbookCategory({
    required super.name,
    required super.children,
    super.isInitiallyExpanded,
  });

  @override
  WidgetbookCategory copyWith({
    String? name,
    List<WidgetbookNode>? children,
  }) {
    return WidgetbookCategory(
      name: name ?? this.name,
      children: children ?? this.children,
      isInitiallyExpanded: isInitiallyExpanded,
    );
  }
}
