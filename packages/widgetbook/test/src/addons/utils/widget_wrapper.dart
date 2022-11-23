import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/addons/addon_provider.dart';
import 'package:widgetbook/src/addons/device_addon/device_provider.dart';
import 'package:widgetbook/src/addons/device_addon/frame_provider.dart';
import 'package:widgetbook/src/addons/theme_addon/theme_provider.dart';
import 'package:widgetbook/src/addons/theme_addon/theme_selection_provider.dart';
import 'package:widgetbook/widgetbook.dart';

import 'custom_app_theme.dart';

const customColor = Colors.blue;
final customTheme = WidgetbookTheme<AppThemeData>(
  name: 'Blue',
  data: AppThemeData(color: customColor),
);

const customColor2 = Colors.yellow;
final customTheme2 = WidgetbookTheme<AppThemeData>(
  name: 'Yellow',
  data: AppThemeData(color: customColor2),
);

final devices = [
  Apple.iPhone11,
  Apple.iPhone12,
  const Device.special(
    name: 'Test',
    resolution: Resolution(
      nativeSize: DeviceSize(width: 400, height: 400),
      scaleFactor: 1,
    ),
  ),
];

final deviceFrameBuilder = DeviceFrameBuilder(
  devices: devices,
);

final activeFrameBuilder = WidgetbookFrameBuilder(
  devices: devices,
);

Widget addOnProviderWrapper({
  required Widget child,
  ThemeSettingProvider<AppThemeData>? provider,
}) =>
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          key: ValueKey(
            devices.take(1).first,
          ),
          create: (context) => DeviceProvider(
            devices.take(1).first,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(customTheme),
        ),
        ChangeNotifierProvider(
          create: (_) => FrameProvider(
            activeFrameBuilder,
          ),
        ),
        ChangeNotifierProvider<AddOnProvider>(
          create: (_) => AddOnProvider(
            [
              CustomThemeAddon<AppThemeData>(
                themeSetting: CustomThemeSetting.firstAsSelected(
                  themes: [customTheme, customTheme2],
                ),
              ),
            ],
          ),
        ),
        if (provider == null)
          ChangeNotifierProvider(
            create: (_) => ThemeSettingProvider(
              CustomThemeSetting<AppThemeData>(
                activeThemes: {customTheme},
                themes: [customTheme, customTheme2],
              ),
            ),
          )
        else
          ChangeNotifierProvider(
            create: (context) => provider,
          ),
      ],
      child: Builder(
        builder: (builder) => MediaQuery.fromWindow(
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: child,
          ),
        ),
      ),
    );
