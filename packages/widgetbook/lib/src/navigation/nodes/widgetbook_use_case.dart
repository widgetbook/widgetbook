import 'package:flutter/material.dart';

import 'widgetbook_node.dart';

/// A navigation node that represents a specific use case of a widget.
///
/// [WidgetbookUseCase] is the leaf node in the navigation tree and contains
/// the actual widget implementation for a specific state or configuration.
/// Each use case typically demonstrates a different scenario, state, or
/// variant of a widget.
///
/// Example:
/// ```dart
/// WidgetbookUseCase(
///   name: 'Loading State',
///   builder: (context) => MyButton(
///     onPressed: null,
///     isLoading: true,
///     child: Text('Loading...'),
///   ),
/// )
/// ```
class WidgetbookUseCase extends WidgetbookNode {
  /// Creates a [WidgetbookUseCase] node.
  WidgetbookUseCase({
    required super.name,
    required this.builder,
    this.designLink,
  }) : super(
         children: null,
         isInitiallyExpanded: false,
       );

  /// @nodoc
  @Deprecated(
    'Use [AlignmentAddon] instead to '
    'control your use-cases alignment. '
    'For more info: https://docs.widgetbook.io/addons/alignment-addon',
  )
  factory WidgetbookUseCase.center({
    required String name,
    required Widget child,
  }) {
    return WidgetbookUseCase(
      name: name,
      builder: (_) => Center(child: child),
    );
  }

  /// Creates a [WidgetbookUseCase] from a static [child] widget.
  ///
  /// This is a convenience factory for creating use cases with static widgets
  /// that don't require access to the build context.
  ///
  /// The [designLink] is an optional URL to the design specifications for this use case.
  factory WidgetbookUseCase.child({
    required String name,
    required Widget child,
    String? designLink,
  }) {
    return WidgetbookUseCase(
      name: name,
      designLink: designLink,
      builder: (_) => child,
    );
  }

  /// A function that builds the widget for this use case.
  ///
  /// This function receives a [BuildContext] and should return the widget
  /// that demonstrates the specific scenario for this use case.
  final WidgetBuilder builder;

  /// An optional URL to the design specifications for this use case.
  ///
  /// This can be used to link to Figma, Sketch, or other design tool files
  /// that show the expected appearance of this use case.
  final String? designLink;

  /// Builds the widget for this use case using the provided [context].
  Widget build(BuildContext context) {
    return builder(context);
  }

  /// Creates a copy of this [WidgetbookUseCase].
  ///
  /// Note: Use cases are immutable leaf nodes, so this always returns
  /// the same instance.
  @override
  WidgetbookUseCase copyWith({
    String? name,
    List<WidgetbookNode>? children,
  }) {
    return this;
  }
}
