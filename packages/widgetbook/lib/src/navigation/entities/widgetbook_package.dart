import 'package:flutter/material.dart';

import 'navigation_entity.dart';

class WidgetbookPackage extends NavigationEntity {
  WidgetbookPackage({
    required super.name,
    required super.children,
    super.isInitiallyExpanded,
  }) : super(
          icon: const Icon(
            Icons.inventory,
            size: 16,
          ),
        );

  @override
  NavigationEntity copyWith({
    required List<NavigationEntity> children,
  }) {
    return WidgetbookPackage(
      name: name,
      children: children,
      isInitiallyExpanded: isInitiallyExpanded,
    );
  }
}
