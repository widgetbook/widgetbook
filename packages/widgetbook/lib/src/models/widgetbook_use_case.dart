import 'package:flutter/material.dart';

import 'package:widgetbook_core/widgetbook_core.dart';

typedef UseCaseBuilder = Widget Function(BuildContext context);

/// UseCases represent a specific configuration of a widget and can be used
/// to check edge cases of a Widget.
class WidgetbookUseCase extends LeafNavigationNodeData {
  const WidgetbookUseCase({
    required super.name,
    required this.builder,
  }) : super(
          type: NavigationNodeType.useCase,
          data: builder,
        );

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

  final UseCaseBuilder builder;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WidgetbookUseCase &&
        other.name == name &&
        other.builder == builder &&
        other.isInitiallyExpanded == other.isInitiallyExpanded;
  }

  @override
  int get hashCode => builder.hashCode;

  @override
  String toString() {
    return 'WidgetbookUseCase('
        'name: $name, '
        'builder: $builder, '
        'isInitiallyExpanded: $isInitiallyExpanded'
        ')';
  }
}
