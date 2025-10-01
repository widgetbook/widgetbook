import 'package:flutter/material.dart';
import 'package:widgetbook/src/theme/theme.dart';
import 'package:widgetbook/widgetbook.dart';

import 'components.book.dart';

final config = Config(
  components: components,
  addons: [
    TimeDilationAddon(),
    ViewportAddon(Viewports.all),
    MaterialThemeAddon({
      'Dark': Themes.dark,
      'Light': Themes.light,
    }),
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
      modes: [MaterialThemeMode('Dark', ThemeData.dark())],
    ),
    ScenarioDefinition(
      name: 'Light',
      modes: [MaterialThemeMode('Light', ThemeData.light())],
    ),
  ],
);
