import 'widgetbook_node.dart';

class WidgetbookPackage extends WidgetbookNode {
  WidgetbookPackage({
    required super.name,
    required super.children,
    super.isInitiallyExpanded,
  });

  @override
  WidgetbookPackage copyWith({
    String? name,
    List<WidgetbookNode>? children,
  }) {
    return WidgetbookPackage(
      name: name ?? this.name,
      children: children ?? this.children,
      isInitiallyExpanded: isInitiallyExpanded,
    );
  }
}
