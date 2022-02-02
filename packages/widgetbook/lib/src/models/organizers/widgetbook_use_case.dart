import 'package:flutter/material.dart';

import 'package:widgetbook/src/models/model.dart';
import 'package:widgetbook/src/models/organizers/organizer.dart';

/// UseCases represent a specific configuration of a widget and can be used
/// to check edge cases of a Widget.
class WidgetbookUseCase extends Organizer implements Model {
  WidgetbookUseCase({required String name, required this.builder})
      : super(name);

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

  final Widget Function(BuildContext) builder;

  @override
  String get id => path;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WidgetbookUseCase && other.builder == builder;
  }

  @override
  int get hashCode => builder.hashCode;

  @override
  String toString() => 'WidgetbookUseCase(name: $name, builder: $builder)';
}
