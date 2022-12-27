// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// WidgetbookGenerator
// **************************************************************************

import 'dart:core';

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_for_widgetbook/app.dart';
import 'package:widgetbook_for_widgetbook/navigation/expander_button.dart';
import 'package:widgetbook_for_widgetbook/navigation/navigation_tree_item.dart';

void main() {
  runApp(HotReload());
}

class HotReload extends StatelessWidget {
  const HotReload({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      appInfo: AppInfo(
        name: 'Widgetbook',
      ),
      themes: [
        WidgetbookTheme(
          name: 'Dark',
          data: theme(),
        ),
      ],
      categories: [
        WidgetbookCategory(
          name: 'use cases',
          folders: [
            WidgetbookFolder(
              name: 'icons',
              widgets: [
                WidgetbookComponent(
                  name: 'ExpanderIcon',
                  useCases: [
                    WidgetbookUseCase(
                      name: 'Default',
                      builder: (context) => expanderButton(context),
                    ),
                  ],
                ),
              ],
              folders: [],
              isExpanded: true,
            ),
            WidgetbookFolder(
              name: 'navigation_tree',
              widgets: [],
              folders: [
                WidgetbookFolder(
                  name: 'widgets',
                  widgets: [
                    WidgetbookComponent(
                      name: 'NavigationTreeItem',
                      useCases: [
                        WidgetbookUseCase(
                          name: 'Default',
                          builder: (context) =>
                              navigationTreeItemWithout(context),
                        ),
                        WidgetbookUseCase(
                          name: 'Category',
                          builder: (context) =>
                              navigationTreeItemCategory(context),
                        ),
                        WidgetbookUseCase(
                          name: 'Package',
                          builder: (context) =>
                              navigationTreeItemPackage(context),
                        ),
                        WidgetbookUseCase(
                          name: 'Folder',
                          builder: (context) =>
                              navigationTreeItemFolder(context),
                        ),
                        WidgetbookUseCase(
                          name: 'Component',
                          builder: (context) =>
                              navigationTreeItemComponent(context),
                        ),
                        WidgetbookUseCase(
                          name: 'Use Case',
                          builder: (context) =>
                              navigationTreeItemUseCase(context),
                        ),
                        WidgetbookUseCase(
                          name: 'Wireframe',
                          builder: (context) =>
                              navigationTreeItemComposition(context),
                        ),
                      ],
                    ),
                  ],
                  folders: [],
                  isExpanded: true,
                ),
              ],
              isExpanded: true,
            ),
          ],
          widgets: [],
        ),
      ],
    );
  }
}
