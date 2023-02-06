import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_core/widgetbook_core.dart';
import 'package:widgetbook_for_widgetbook/navigation/navigation_test_data.dart';

@WidgetbookUseCase(name: 'Default', type: NavigationTreeNode)
Widget navigationTreeNodeDefaultUseCase(BuildContext context) {
  return const NavigationTreeNode(
    data: testNode5,
  );
}
