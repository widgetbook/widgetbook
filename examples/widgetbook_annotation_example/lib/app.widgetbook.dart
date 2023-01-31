// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// WidgetbookGenerator
// **************************************************************************

import 'dart:core';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meal_app/app.dart';
import 'package:meal_app/constants/border.dart';
import 'package:meal_app/constants/color.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/themes/dark_theme.dart';
import 'package:meal_app/themes/light_theme.dart';
import 'package:meal_app/widgets/attributes/attribute.dart';
import 'package:meal_app/widgets/attributes/price_attribute.dart';
import 'package:meal_app/widgets/attributes/weight_attribute.dart';
import 'package:meal_app/widgets/ingredients.dart';
import 'package:meal_app/widgets/meal_detail.dart';
import 'package:meal_app/widgets/new_tag.dart';
import 'package:meal_app/widgets/rotated_image.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  runApp(HotReload());
}

class HotReload extends StatelessWidget {
  const HotReload({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      appInfo: AppInfo(
        name: 'Meal App',
      ),
      addons: [
        CustomThemeAddon<ThemeData>(
          setting: ThemeSetting<ThemeData>(
            themes: [
              WidgetbookTheme(
                name: 'Dark',
                data: getDarkThemeData(),
              ),
              WidgetbookTheme(
                name: 'Light',
                data: getLightThemeData(),
              ),
            ],
            activeTheme: WidgetbookTheme(
              name: 'Dark',
              data: getDarkThemeData(),
            ),
          ),
        ),
        TextScaleAddon(
          setting: TextScaleSetting(
            textScales: [
              1.0,
              2.0,
              3.0,
            ],
            activeTextScale: 1.0,
          ),
        ),
        LocalizationAddon(
          setting: LocalizationSetting(
            locales: locales,
            activeLocale: locales.first,
            localizationsDelegates: delegates,
          ),
        ),
        FrameAddon(
          setting: FrameSetting(
            frames: [
              NoFrame(),
              DefaultDeviceFrame(
                setting: DeviceSetting(
                  devices: [
                    Device(
                      name: 'iPhone 12',
                      resolution: Resolution(
                        nativeSize: DeviceSize(
                          height: 2532.0,
                          width: 1170.0,
                        ),
                        scaleFactor: 3.0,
                      ),
                      type: DeviceType.mobile,
                    ),
                  ],
                  activeDevice: Device(
                    name: 'iPhone 12',
                    resolution: Resolution(
                      nativeSize: DeviceSize(
                        height: 2532.0,
                        width: 1170.0,
                      ),
                      scaleFactor: 3.0,
                    ),
                    type: DeviceType.mobile,
                  ),
                ),
              ),
              WidgetbookFrame(
                setting: DeviceSetting(
                  devices: [
                    Device(
                      name: 'iPhone 12',
                      resolution: Resolution(
                        nativeSize: DeviceSize(
                          height: 2532.0,
                          width: 1170.0,
                        ),
                        scaleFactor: 3.0,
                      ),
                      type: DeviceType.mobile,
                    ),
                  ],
                  activeDevice: Device(
                    name: 'iPhone 12',
                    resolution: Resolution(
                      nativeSize: DeviceSize(
                        height: 2532.0,
                        width: 1170.0,
                      ),
                      scaleFactor: 3.0,
                    ),
                    type: DeviceType.mobile,
                  ),
                ),
              ),
            ],
            activeFrame: NoFrame(),
          ),
        ),
      ],
      directories: [
        WidgetbookFolder(
          name: 'widgets',
          children: [
            WidgetbookComponent(
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
              isInitiallyExpanded: true,
            ),
            WidgetbookFolder(
              name: 'attributes',
              children: [
                WidgetbookComponent(
                  name: 'Attribute',
                  useCases: [
                    WidgetbookUseCase(
                      name: 'weight',
                      builder: (context) => attributeStory(context),
                    ),
                  ],
                  isInitiallyExpanded: true,
                ),
              ],
              isInitiallyExpanded: true,
            ),
          ],
          isInitiallyExpanded: true,
        ),
      ],
    );
  }
}
