import 'widgetbook_node.dart';

class WidgetbookFolder extends WidgetbookNode {
  WidgetbookFolder({
    required super.name,
    required super.children,
    super.isInitiallyExpanded,
  });

  @override
  WidgetbookFolder copyWith({
    String? name,
    List<WidgetbookNode>? children,
  }) {
    return WidgetbookFolder(
      name: name ?? this.name,
      children: children ?? this.children,
      isInitiallyExpanded: isInitiallyExpanded,
    );
  }
}
