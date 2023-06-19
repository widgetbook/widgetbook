import 'package:flutter/material.dart';

import 'navigation_entity.dart';

class WidgetbookCategory extends NavigationEntity {
  WidgetbookCategory({
    required super.name,
    required super.children,
    super.isInitiallyExpanded,
  }) : super(
          icon: const Icon(
            Icons.auto_awesome_mosaic,
            size: 16,
          ),
        );

  @override
  NavigationEntity copyWith({
    required List<NavigationEntity> children,
  }) {
    return WidgetbookCategory(
      name: name,
      children: children,
      isInitiallyExpanded: isInitiallyExpanded,
    );
  }
}
