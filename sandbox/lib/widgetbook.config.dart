import 'package:flutter/material.dart' hide ThemeMode;
import 'package:widgetbook/src/theme/theme.dart';
import 'package:widgetbook/widgetbook.dart';

import 'components.book.dart';

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
    ThemeAddon<ThemeData>(
      {
        'Dark': Themes.dark,
        'Light': Themes.light,
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
        ThemeMode<ThemeData>('Dark', Themes.dark, multiThemeBuilder),
      ],
    ),
    ScenarioDefinition(
      name: 'Light',
      modes: [
        ThemeMode<ThemeData>('Light', Themes.light, multiThemeBuilder),
      ],
    ),
  ],
);

// Sandbox needs two inherited theme widgets:
// 1. `WidgetbookTheme` for Widgetbook's components (e.g. `NullableSetting`)
// 2. `Theme` for material-based components (e.g. `LabelBadge`)
Widget multiThemeBuilder(
  BuildContext context,
  ThemeData data,
  Widget child,
) {
  return WidgetbookTheme(
    data: data,
    child: Theme(
      data: data,
      child: ColoredBox(
        color: data.scaffoldBackgroundColor,
        child: DefaultTextStyle(
          style: data.textTheme.bodyMedium!,
          child: child,
        ),
      ),
    ),
  );
}
