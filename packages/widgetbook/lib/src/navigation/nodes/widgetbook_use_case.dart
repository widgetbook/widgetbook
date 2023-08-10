import 'package:flutter/material.dart';

import 'tree_node.dart';

/// UseCases represent a specific configuration of a widget and can be used
/// to check edge cases of a Widget.
class WidgetbookUseCase extends TreeNode {
  WidgetbookUseCase({
    required super.name,
    required this.builder,
  }) : super(children: null);

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
  }) {
    return WidgetbookUseCase(
      name: name,
      builder: (_) => child,
    );
  }

  final WidgetBuilder builder;
}
