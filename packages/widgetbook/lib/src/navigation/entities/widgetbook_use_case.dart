import 'dart:math';

import 'package:flutter/material.dart';

import 'navigation_entity.dart';

typedef UseCaseBuilder = Widget Function(BuildContext context);

/// UseCases represent a specific configuration of a widget and can be used
/// to check edge cases of a Widget.
class WidgetbookUseCase extends NavigationEntity {
  WidgetbookUseCase({
    required super.name,
    required this.builder,
  }) : super(
          isInitiallyExpanded: false,
          icon: Transform.rotate(
            angle: 45 * pi / 180,
            child: const Icon(
              Icons.square_rounded,
              size: 14.0,
            ),
          ),
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
  NavigationEntity copyWith({
    required List<NavigationEntity> children,
  }) {
    return this;
  }
}
