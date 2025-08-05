import 'widgetbook_node.dart';

/// A navigation node that represents a category in the widget library.
///
/// This category can contain multiple components and use-cases.
/// [WidgetbookCategory] is used to group related components or other categories
/// into a hierarchical structure. This helps in categorizing widgets by
/// functionality, design system sections, or any other logical grouping.
///
/// Example:
///
/// ```dart
/// WidgetbookCategory(
///   name: 'Buttons',
///   children: [ ... ],
/// )
/// ```
class WidgetbookCategory extends WidgetbookNode {
  /// Creates a [WidgetbookCategory] node.
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
