import 'package:flutter/material.dart';
import 'package:widgetbook/next.dart' as next;
import 'package:widgetbook/src/themes.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import 'components.book.dart';
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
      directories: [...directories, ...components],
      addons: [
        ViewportAddon(Viewports.all),
        SemanticsAddon(),
        next.TimeDilationAddon(),
        next.MaterialThemeAddon({'Dark': Themes.dark, 'Light': Themes.light}),
        next.GridAddon(),
        next.AlignmentAddon(),
        next.TextScaleAddon(),
        next.LocaleAddon(
          [const Locale('en', 'US')],
          [
            DefaultWidgetsLocalizations.delegate,
            DefaultMaterialLocalizations.delegate,
          ],
        ),
        next.BuilderAddon(
          name: 'Bounds',
          builder:
              (context, child) => Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                ),
                child: child,
              ),
        ),
      ],
    );
  }
}
