import 'package:flutter/material.dart' hide ThemeMode;
import 'package:widgetbook/widgetbook.dart';

import 'components.g.dart';
import 'theme.dart';

final config = Config(
  components: components,
  addons: [
    TimeDilationAddon(),
    ViewportAddon([
      Viewports.none,
      IosViewports.iPhone13,
      const ViewportData.constrained(
        name: '800w',
        pixelRatio: 2,
        maxWidth: 800,
        platform: TargetPlatform.iOS,
      ),
    ]),
    ThemeAddon<MultiThemeData>(
      {
        'Dark': multiDarkTheme,
        'Light': multiLightTheme,
      },
      multiThemeBuilder,
    ),
    GridAddon(),
    AlignmentAddon(),
    TextScaleAddon(),
    LocaleAddon(
      [const Locale('en', 'US')],
      [
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
  scenarios: [
    ScenarioDefinition(
      name: 'Dark',
      modes: [
        ThemeMode<MultiThemeData>(
          'Dark',
          multiDarkTheme,
          multiThemeBuilder,
        ),
      ],
    ),
    ScenarioDefinition(
      name: 'Light',
      modes: [
        ThemeMode<MultiThemeData>(
          'Light',
          multiLightTheme,
          multiThemeBuilder,
        ),
      ],
    ),
  ],
);
