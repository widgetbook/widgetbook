import 'widgetbook_node.dart';

/// A navigation node that represents a folder in the widget library.
///
/// [WidgetbookFolder] is used to organize related components or other folders
/// into a hierarchical structure. This helps in categorizing widgets by
/// functionality, design system sections, or any other logical grouping.
///
/// Example:
/// ```dart
/// WidgetbookFolder(
///   name: 'Buttons',
///   children: [ ... ],
/// )
/// ```
class WidgetbookFolder extends WidgetbookNode {
  /// Creates a [WidgetbookFolder] node
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
