import 'package:flutter/material.dart';

import '../nodes/nodes.dart';
import 'component_icon.dart';
import 'use_case_icon.dart';

Widget resolveIcon(WidgetbookNode node) {
  switch (node.runtimeType) {
    case WidgetbookPackage:
      return const Icon(Icons.inventory, size: 16);
    case WidgetbookCategory:
      return const Icon(Icons.auto_awesome_mosaic, size: 16);
    case WidgetbookFolder:
      return const Icon(Icons.folder, size: 16);
    case WidgetbookComponent:
      return const ComponentIcon();
    case WidgetbookUseCase:
      return const UseCaseIcon();
    default:
      return const SizedBox();
  }
}
