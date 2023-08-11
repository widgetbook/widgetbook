import 'widgetbook_node.dart';

class WidgetbookRoot extends WidgetbookNode {
  WidgetbookRoot({
    required super.children,
  }) : super(
          name: '',
          isInitiallyExpanded: true,
        );

  @override
  WidgetbookRoot copyWith({
    String? name,
    List<WidgetbookNode>? children,
  }) {
    return WidgetbookRoot(
      children: children ?? this.children,
    );
  }
}
