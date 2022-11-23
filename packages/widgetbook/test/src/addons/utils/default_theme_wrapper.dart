import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/addons/addon_provider.dart';
import 'package:widgetbook/src/addons/device_addon/device_provider.dart';
import 'package:widgetbook/src/addons/device_addon/frame_provider.dart';
import 'package:widgetbook/src/addons/theme_addon/theme_provider.dart';
import 'package:widgetbook/src/addons/theme_addon/theme_selection_provider.dart';
import 'package:widgetbook/widgetbook.dart';

import 'addons.dart';
import 'custom_app_theme.dart';

Widget addOnProviderWrapper<T>({
  required Widget child,
  ThemeSettingProvider<T>? provider,
  required ThemeAddon<T> themeAddon,
  required ThemeSetting<T> themeSetting,
  required WidgetbookTheme<T> theme
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
          create: (_) => ThemeProvider(theme),
        ),
        ChangeNotifierProvider(
          create: (_) => FrameProvider(
            activeFrameBuilder,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => AddOnProvider(
            [themeAddon],
          ),
        ),
        if (provider == null)
          ChangeNotifierProvider(
            create: (_) => ThemeSettingProvider(
              themeSetting,
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
