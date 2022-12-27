import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart' show Knobs, Option;
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

@WidgetbookUseCase(name: 'Default', type: NavigationTreeItem)
Widget navigationTreeItemWithout(BuildContext context) {
  final icon = context.knobs.options<dynamic>(
    label: 'Icon',
    options: const [
      Option(
        label: 'Category',
        value: Icons.auto_awesome_mosaic,
      ),
      Option(
        label: 'Package',
        value: Icons.inventory,
      ),
      Option(
        label: 'Folder',
        value: Icons.folder,
      ),
      Option(
        label: 'Use Case',
        value: UseCaseIcon(),
      ),
      Option(
        label: 'Component',
        value: ComponentIcon(),
      ),
    ],
  );

  return NavigationTreeItem(
    label: context.knobs.text(
      label: 'Label',
      initialValue: 'Category',
    ),
    level: context.knobs.slider(
      label: 'Level',
      initialValue: 0,
      min: 0,
      max: 20,
      divisions: 20,
    ).toInt(),
    iconData: icon is IconData ? icon : null,
    icon: icon is Widget ? icon : null,
    onTap: () {},
    onMoreIconPressed: () {},
    isExpanded: context.knobs.boolean(
      label: 'Can Expand',
      initialValue: true,
    )
        ? context.knobs.boolean(label: 'Is Expanded')
        : null,
  );
}

@WidgetbookUseCase(name: 'Category', type: NavigationTreeItem)
Widget navigationTreeItemCategory(BuildContext context) {
  return NavigationTreeItem.category(
    label: context.knobs.text(
      label: 'Label',
      initialValue: 'Category',
    ),
    onTap: () {},
    onMoreIconPressed: () {},
  );
}

@WidgetbookUseCase(name: 'Package', type: NavigationTreeItem)
Widget navigationTreeItemPackage(BuildContext context) {
  return NavigationTreeItem.package(
    label: context.knobs.text(
      label: 'Label',
      initialValue: 'Package',
    ),
    onTap: () {},
    onMoreIconPressed: () {},
  );
}

@WidgetbookUseCase(name: 'Folder', type: NavigationTreeItem)
Widget navigationTreeItemFolder(BuildContext context) {
  return NavigationTreeItem.folder(
    label: context.knobs.text(
      label: 'Label',
      initialValue: 'Folder',
    ),
    level: 1,
    onTap: () {},
    onMoreIconPressed: () {},
  );
}

@WidgetbookUseCase(name: 'Component', type: NavigationTreeItem)
Widget navigationTreeItemComponent(BuildContext context) {
  return NavigationTreeItem.component(
    label: context.knobs.text(
      label: 'Label',
      initialValue: 'Component',
    ),
    level: 1,
    onTap: () {},
    onMoreIconPressed: () {},
  );
}

@WidgetbookUseCase(name: 'Use Case', type: NavigationTreeItem)
Widget navigationTreeItemUseCase(BuildContext context) {
  return NavigationTreeItem.useCase(
    label: context.knobs.text(
      label: 'Label',
      initialValue: 'Use Case',
    ),
    level: 1,
  );
}

@WidgetbookUseCase(name: 'Wireframe', type: NavigationTreeItem)
Widget navigationTreeItemComposition(BuildContext context) {
  final categoryLabel = context.knobs.text(
    label: 'Category Label',
    initialValue: 'Category',
  );
  final packageLabel = context.knobs.text(
    label: 'Package Label',
    initialValue: 'Package',
  );
  final folderLabel = context.knobs.text(
    label: 'Folder Label',
    initialValue: 'Folder',
  );
  final componentLabel = context.knobs.text(
    label: 'Component Label',
    initialValue: 'Component',
  );
  final useCaseLabel = context.knobs.text(
    label: 'Use Case Label',
    initialValue: 'Use Case',
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      NavigationTreeItem.category(
        label: categoryLabel,
        onTap: () {},
        onMoreIconPressed: () {},
      ),
      NavigationTreeItem.folder(
        label: folderLabel,
        level: 1,
        onTap: () {},
        onMoreIconPressed: () {},
      ),
      NavigationTreeItem.component(
        label: componentLabel,
        level: 2,
        onTap: () {},
        onMoreIconPressed: () {},
      ),
      NavigationTreeItem.useCase(
        label: useCaseLabel,
        level: 3,
        onTap: () {},
        onMoreIconPressed: () {},
      ),
      ...List.generate(
        12,
        (index) => index == 0
            ? NavigationTreeItem.package(
                label: packageLabel,
                onTap: () {},
                onMoreIconPressed: () {},
              )
            : index == 11
                ? NavigationTreeItem.useCase(
                    label: useCaseLabel,
                    level: index,
                    onTap: () {},
                    onMoreIconPressed: () {},
                  )
                : NavigationTreeItem.component(
                    label: componentLabel,
                    level: index,
                    onTap: () {},
                    onMoreIconPressed: () {},
                  ),
      ),
    ],
  );
}
