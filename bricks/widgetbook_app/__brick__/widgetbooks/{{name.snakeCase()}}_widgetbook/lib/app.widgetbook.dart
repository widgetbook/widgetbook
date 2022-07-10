// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// WidgetbookGenerator
// **************************************************************************

import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/material/button.dart';
import 'package:flutter/src/material/color_scheme.dart';
import 'package:flutter/src/material/floating_action_button_theme.dart';
import 'package:flutter/src/material/scaffold.dart';
import 'package:flutter/src/material/text_theme.dart';
import 'package:flutter/src/material/theme.dart';
import 'package:flutter/src/material/theme_data.dart';
import 'package:flutter/src/material/tooltip.dart';
import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:{{name.snakeCase()}}_widgetbook/app.dart';
import 'package:{{name.snakeCase()}}_widgetbook/components.dart';

void main() {
  runApp(HotReload());
}

class HotReload extends StatelessWidget {
  const HotReload({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      appInfo: AppInfo(
        name: '{{package.pascalCase()}}',
      ),
      themes: [
        WidgetbookTheme(
          name: 'Light',
          data: lightTheme(),
        ),
        WidgetbookTheme(
          name: 'Dark',
          data: darkTheme(),
        ),
      ],
      categories: [
        WidgetbookCategory(
          name: 'use cases',
          folders: [
            WidgetbookFolder(
              name: 'material',
              widgets: [
                WidgetbookComponent(
                  name: 'FloatingActionButton',
                  useCases: [
                    WidgetbookUseCase(
                      name: 'Default',
                      builder: (context) => buildFab(context),
                    ),
                  ],
                ),
              ],
              folders: [],
            ),
          ],
          widgets: [],
        ),
      ],
    );
  }
}
