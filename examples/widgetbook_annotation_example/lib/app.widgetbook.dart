// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// WidgetbookGenerator
// **************************************************************************

import 'dart:core';

import 'package:flutter/material.dart';
import 'package:meal_app/app.dart';
import 'package:meal_app/themes/dark_theme.dart';
import 'package:meal_app/themes/light_theme.dart';
import 'package:meal_app/widgets/attributes/attribute.dart';
import 'package:meal_app/widgets/meal_detail.dart';
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
      categories: [
        WidgetbookCategory(
          name: 'use cases',
          folders: [
            WidgetbookFolder(
              name: 'widgets',
              widgets: [
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
                  isExpanded: true,
                ),
              ],
              folders: [
                WidgetbookFolder(
                  name: 'attributes',
                  widgets: [
                    WidgetbookComponent(
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
