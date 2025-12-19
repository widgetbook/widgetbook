import 'package:flutter/material.dart';
import 'package:widgetbook/src/themes.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import 'widgetbook.directories.g.dart';

void main() {
  runApp(const WidgetbookApp());
}

@App(
  cloudAddonsConfigs: {
    'German Dark Center x2': [
      ViewportAddonConfig(IosViewports.iPhone12),
      LocalizationAddonConfig('de'),
      ThemeAddonConfig('Dark'),
      AlignmentAddonConfig('Center'),
      TextScaleAddonConfig(2),
      ZoomAddonConfig(2),
      SemanticsAddonConfig(true),
      AddonConfig('custom-addon', 'name:value'),
    ],
    'English': [LocalizationAddonConfig('en')],
  },
)
class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      directories: directories,
      addons: [
        ViewportAddon(Viewports.all),
        TimeDilationAddon(),
        MaterialThemeAddon(
          themes: [
            WidgetbookTheme(name: 'Dark', data: Themes.dark),
            WidgetbookTheme(name: 'Light', data: Themes.light),
          ],
        ),
        GridAddon(),
        AlignmentAddon(),
        TextScaleAddon(),
        LocalizationAddon(
          locales: [const Locale('en', 'US')],
          localizationsDelegates: [
            DefaultWidgetsLocalizations.delegate,
            DefaultMaterialLocalizations.delegate,
          ],
        ),
        BuilderAddon(
          name: 'Bounds',
          builder: (context, child) => Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
            ),
            child: child,
          ),
        ),
        SemanticsAddon(),
      ],
    );
  }
}
