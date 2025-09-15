import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../widgetbook.dart';
import '../nodes/nodes.dart';
import 'component_icon.dart';
import 'use_case_icon.dart';

@internal
Widget resolveIcon(WidgetbookNode node) {
  if (node is WidgetbookPackage) {
    return const Icon(Icons.inventory, size: 16);
  } else if (node is WidgetbookCategory) {
    return const Icon(Icons.auto_awesome_mosaic, size: 16);
  } else if (node is WidgetbookFolder) {
    return const Icon(Icons.folder, size: 16);
  } else if (node is WidgetbookComponent) {
    return const ComponentIcon();
  } else if (node is WidgetbookUseCase) {
    return const UseCaseIcon();
  } else {
    return const SizedBox();
  }
}
