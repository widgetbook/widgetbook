import 'package:flutter/material.dart';

import 'navigation_entity.dart';

class WidgetbookFolder extends NavigationEntity {
  WidgetbookFolder({
    required super.name,
    required super.children,
    super.isInitiallyExpanded,
  }) : super(
          icon: const Icon(
            Icons.folder,
            size: 16,
          ),
        );

  @override
  NavigationEntity copyWith({
    required List<NavigationEntity> children,
  }) {
    return WidgetbookFolder(
      name: name,
      children: children,
      isInitiallyExpanded: isInitiallyExpanded,
    );
  }
}
