import 'package:flutter/cupertino.dart';
import 'package:widgetbook/src/builder/models/app_builder_function.dart';
import 'package:widgetbook/widgetbook.dart';

import 'custom_app_theme.dart';

CupertinoThemeData get bluetheme => const CupertinoThemeData(
      primaryColor: colorBlue,
    );

CupertinoThemeData get yellowtheme => const CupertinoThemeData(
      primaryColor: colorYellow,
    );

final blueCupertinoWidgetbookTheme =
    WidgetbookTheme(name: 'Blue', data: bluetheme);

final yellowCupertinoWidgetbookTheme =
    WidgetbookTheme(name: 'Yellow', data: yellowtheme);

final cupertinoThemeSetting = CupertinoThemeSetting(
  activeTheme: blueCupertinoWidgetbookTheme,
  themes: [blueCupertinoWidgetbookTheme, yellowCupertinoWidgetbookTheme],
);

final cupertinoThemeAddon = CupertinoThemeAddon(
  setting: cupertinoThemeSetting,
);

AppBuilderFunction get cupertinoAppBuilder =>
    (BuildContext context, Widget child) {
      return CupertinoTheme(
        data: context.cupertinoTheme!,
        child: child,
      );
    };
