import 'package:flutter/material.dart';
import 'package:widgetbook/src/navigation/navigation.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: NavigationTreeTile)
Widget navigationTreeItemWithout(BuildContext context) {
  return Column(
    children: [
      NavigationTreeTile(
        node: WidgetbookCategory(
          name: context.knobs.string(
            label: 'Name',
            initialValue: 'Category',
          ),
          children: [],
        ),
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
