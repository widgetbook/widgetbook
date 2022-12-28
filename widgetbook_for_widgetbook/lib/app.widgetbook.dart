// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// WidgetbookGenerator
// **************************************************************************

import 'dart:core';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_core/src/navigation_tree/navigation_tree.dart';
import 'package:widgetbook_core/widgetbook_core.dart';
import 'package:widgetbook_for_widgetbook/app.dart';
import 'package:widgetbook_for_widgetbook/navigation/expander_button.dart';
import 'package:widgetbook_for_widgetbook/navigation/navigation_tree.dart';
import 'package:widgetbook_for_widgetbook/navigation/navigation_tree_item.dart';
import 'package:widgetbook_for_widgetbook/navigation/navigation_tree_node.dart';
import 'package:widgetbook_for_widgetbook/search/search.dart';

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
              name: 'search',
              widgets: [],
              folders: [
                WidgetbookFolder(
                  name: 'widgets',
                  widgets: [
                    WidgetbookComponent(
                      name: 'SearchField',
                      useCases: [
                        WidgetbookUseCase(
                          name: 'Default',
                          builder: (context) =>
                              searchFieldDefaultUseCase(context),
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
                      name: 'NavigationTree',
                      useCases: [
                        WidgetbookUseCase(
                          name: 'Default',
                          builder: (context) =>
                              navigationTreeDefaultUseCase(context),
                        ),
                      ],
                    ),
                    WidgetbookComponent(
                      name: 'NavigationTreeNode',
                      useCases: [
                        WidgetbookUseCase(
                          name: 'Default',
                          builder: (context) =>
                              navigationTreeNodeDefaultUseCase(context),
                        ),
                      ],
                    ),
                    WidgetbookComponent(
                      name: 'NavigationTreeItem',
                      useCases: [
                        WidgetbookUseCase(
                          name: 'Default',
                          builder: (context) =>
                              navigationTreeItemWithout(context),
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
