import 'package:flutter/material.dart';
import 'package:widgetbook/src/builder/models/app_builder_function.dart';
import 'package:widgetbook/widgetbook.dart';

import 'custom_app_theme.dart';

ThemeData get bluetheme => ThemeData(
      primaryColor: colorBlue,
    );

ThemeData get yellowtheme => ThemeData(
      primaryColor: colorYellow,
    );

final blueMaterialWidgetbookTheme =
    WidgetbookTheme(name: 'Blue', data: bluetheme);

final yellowMaterialWidgetbookTheme =
    WidgetbookTheme(name: 'Yellow', data: yellowtheme);

final materialThemeSetting = MaterialThemeSetting(
  activeTheme: blueMaterialWidgetbookTheme,
  themes: [blueMaterialWidgetbookTheme, yellowMaterialWidgetbookTheme],
);

final materialThemeAddon = MaterialThemeAddon(
  setting: materialThemeSetting,
);

AppBuilderFunction get materialAppBuilder =>
    (BuildContext context, Widget child) => Theme(
          data: context.materialTheme!,
          child: child,
        );
