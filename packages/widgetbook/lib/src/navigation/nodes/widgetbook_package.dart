import 'widgetbook_node.dart';

/// A navigation node that represents a package in the widget library.
///
/// [WidgetbookPackage] is used to group related components, folders, or other
/// packages together. This is used to organize widgets by functionality,
/// design system sections, or any other logical grouping.
///
/// Example:
/// ```dart
/// WidgetbookPackage(
///   name: 'Material',
///   children: [...],
/// )
/// ```
class WidgetbookPackage extends WidgetbookNode {
  /// Creates a [WidgetbookPackage] node.
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
