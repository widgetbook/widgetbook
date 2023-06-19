import 'dart:math';

import 'package:flutter/material.dart';

import 'navigation_entity.dart';
import 'widgetbook_use_case.dart';

class WidgetbookComponent extends NavigationEntity {
  WidgetbookComponent({
    required super.name,
    required List<WidgetbookUseCase> useCases,
    super.isInitiallyExpanded,
  }) : super(
          children: useCases,
          icon: Center(
            heightFactor: 1,
            child: SizedBox(
              width: _iconSize,
              height: _iconSize,
              child: Transform.rotate(
                angle: 45 * pi / 180,
                child: GridView.count(
                  crossAxisCount: 2,
                  padding: EdgeInsets.zero,
                  children: List.generate(
                    4,
                    (index) => const Icon(
                      Icons.square_rounded,
                      size: _iconSize / 2,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );

  static const _iconSize = 12.0;

  @override
  NavigationEntity copyWith({
    required List<NavigationEntity> children,
  }) {
    return WidgetbookComponent(
      name: name,
      useCases: children as List<WidgetbookUseCase>,
      isInitiallyExpanded: isInitiallyExpanded,
    );
  }
}
