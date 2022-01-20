// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// WidgetbookGenerator
// **************************************************************************

import 'package:meal_app/themes/light_theme.dart';
import 'package:meal_app/constants/color.dart';
import 'dart:core';
import 'package:meal_app/constants/border.dart';
import 'package:flutter/material.dart';
import 'package:meal_app/themes/dark_theme.dart';
import 'package:meal_app/widgets/attributes/attribute.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meal_app/widgets/meal_detail.dart';
import 'package:meal_app/widgets/rotated_image.dart';
import 'package:meal_app/widgets/ingredients.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/widgets/attributes/weight_attribute.dart';
import 'package:meal_app/widgets/new_tag.dart';
import 'package:meal_app/widgets/attributes/price_attribute.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  runApp(HotReload());
}

class HotReload extends StatelessWidget {
  const HotReload({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Widgetbook(
      appInfo: AppInfo(
        name: 'Meal App',
      ),
      lightTheme: getLightThemeData(),
      darkTheme: getDarkThemeData(),
      defaultTheme: ThemeMode.dark,
      categories: [
        WidgetbookCategory(
          name: 'use cases',
          folders: [
            WidgetbookFolder(
              name: 'widgets',
              widgets: [
                WidgetbookWidget(
                  name: 'MealDetail',
                  useCases: [
                    WidgetbookUseCase(
                      name: 'short name',
                      builder: (context) => mealDetailShort(context),
                    ),
                    WidgetbookUseCase(
                      name: 'long name',
                      builder: (context) => mealDetailLong(context),
                    ),
                  ],
                  isExpanded: true,
                ),
              ],
              folders: [
                WidgetbookFolder(
                  name: 'attributes',
                  widgets: [
                    WidgetbookWidget(
                      name: 'Attribute',
                      useCases: [
                        WidgetbookUseCase(
                          name: 'weight',
                          builder: (context) => attributeStory(context),
                        ),
                      ],
                      isExpanded: true,
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
