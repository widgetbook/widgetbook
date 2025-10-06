import 'package:flutter/material.dart';
import 'package:widgetbook/src/theme/theme.dart';

// Sandbox needs two inherited theme widgets:
// 1. `WidgetbookTheme` for Widgetbook's components (e.g. `NullableSetting`)
// 2. `Theme` for material-based components (e.g. `LabelBadge`)
Widget multiThemeBuilder(
  BuildContext context,
  MultiThemeData data,
  Widget child,
) {
  return WidgetbookTheme(
    data: data.widgetbook,
    child: Theme(
      data: data.material,
      child: ColoredBox(
        color: data.material.scaffoldBackgroundColor,
        child: DefaultTextStyle(
          style: data.material.textTheme.bodyMedium!,
          child: child,
        ),
      ),
    ),
  );
}

final multiDarkTheme = MultiThemeData(
  material: ThemeData.dark(),
  widgetbook: Themes.dark,
);

final multiLightTheme = MultiThemeData(
  material: ThemeData.light(),
  widgetbook: Themes.light,
);

class MultiThemeData {
  MultiThemeData({
    required this.material,
    required this.widgetbook,
  });

  final ThemeData material;
  final ThemeData widgetbook;
}
