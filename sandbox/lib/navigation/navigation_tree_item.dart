// ignore_for_file: invalid_use_of_internal_member

import 'package:flutter/material.dart';
import 'package:widgetbook/src/navigation/navigation.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: NavigationTreeItem)
Widget navigationTreeItemWithout(BuildContext context) {
  return Column(
    children: [
      NavigationTreeItem(
        data: WidgetbookCategory(
          name: context.knobs.string(
            label: 'Name',
            initialValue: 'Category',
          ),
          children: [],
        ),
        level: context.knobs.double
            .slider(
              label: 'Level',
              initialValue: 0,
              min: 0,
              max: 20,
              divisions: 20,
            )
            .toInt(),
        onTap: () {},
        isExpanded: context.knobs.boolean(
          label: 'Is Expanded',
        ),
        isSelected: context.knobs.boolean(
          label: 'Is Selected',
        ),
      ),
    ],
  );
}
