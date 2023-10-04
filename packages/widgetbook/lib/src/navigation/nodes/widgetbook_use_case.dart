import 'package:flutter/material.dart';

import 'widgetbook_node.dart';

/// UseCases represent a specific configuration of a widget and can be used
/// to check edge cases of a Widget.
class WidgetbookUseCase extends WidgetbookNode {
  WidgetbookUseCase({
    required super.name,
    required this.builder,
    this.designLink,
  }) : super(
          children: null,
          isInitiallyExpanded: false,
        );

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

  final WidgetBuilder builder;
  final String? designLink;

  @override
  WidgetbookUseCase copyWith({
    String? name,
    List<WidgetbookNode>? children,
  }) {
    return this;
  }
}
