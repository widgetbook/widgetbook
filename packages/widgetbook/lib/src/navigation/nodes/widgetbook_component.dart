import 'widgetbook_node.dart';
import 'widgetbook_use_case.dart';

/// A navigation node that represents a component in the widget library.
///
/// [WidgetbookComponent] organizes related [WidgetbookUseCase]s under a single
/// component name. This is typically used to group different states or
/// configurations of the same widget.
///
/// When this has a single use-case (i.e. also known as leaf component),
/// this is represented as a "component" in the navigation tree but acts like
/// a "use-case".
///
/// Example:
/// ```dart
/// WidgetbookComponent(
///   name: 'Button',
///   useCases: [
///     WidgetbookUseCase(
///       name: 'Primary',
///       builder: (context) => ElevatedButton(
///         onPressed: () {},
///         child: Text('Primary Button'),
///       ),
///     ),
///     WidgetbookUseCase(
///       name: 'Secondary',
///       builder: (context) => OutlinedButton(
///         onPressed: () {},
///         child: Text('Secondary Button'),
///       ),
///     ),
///   ],
/// )
/// ```
class WidgetbookComponent extends WidgetbookNode {
  /// Creates a [WidgetbookComponent] node.
  WidgetbookComponent({
    required super.name,
    required this.useCases,
    super.isInitiallyExpanded,
  }) : super(
         children: useCases,
       );

  /// The list of use cases that belong to this component.
  ///
  /// Each use case represents a different state or configuration of the widget.
  final List<WidgetbookUseCase> useCases;

  @override
  WidgetbookComponent copyWith({
    String? name,
    List<WidgetbookNode>? children,
  }) {
    return WidgetbookComponent(
      name: name ?? this.name,
      useCases: children?.cast<WidgetbookUseCase>() ?? this.useCases,
      isInitiallyExpanded: isInitiallyExpanded,
    );
  }
}
