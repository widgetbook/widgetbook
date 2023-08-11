import 'widgetbook_node.dart';

/// The root of all [WidgetbookNode]s.
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
