// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// WidgetbookGenerator
// **************************************************************************

import 'dart:core';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_core/widgetbook_core.dart';
import 'package:widgetbook_for_widgetbook/app.dart';

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
              name: 'navigation_tree',
              widgets: [],
              folders: [
                WidgetbookFolder(
                  name: 'widgets',
                  widgets: [
                    WidgetbookComponent(
                      name: 'ExpanderButton',
                      useCases: [
                        WidgetbookUseCase(
                          name: 'Default',
                          builder: (context) => expanderButton(context),
                        ),
                      ],
                    ),
                  ],
                  folders: [],
                ),
              ],
            ),
          ],
          widgets: [],
        ),
      ],
    );
  }
}
