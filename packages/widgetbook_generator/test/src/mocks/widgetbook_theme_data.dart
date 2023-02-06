import 'package:widgetbook_generator/models/widgetbook_theme_data.dart';

final themeDark = WidgetbookThemeData(
  dependencies: [],
  name: 'getDarkTheme',
  isDefault: false,
  themeName: 'Dark',
  importStatement: '',
);

final themeLight = WidgetbookThemeData(
  dependencies: [],
  name: 'getLightTheme',
  isDefault: false,
  themeName: 'Light',
  importStatement: '',
);
final themes = [themeLight, themeDark];
