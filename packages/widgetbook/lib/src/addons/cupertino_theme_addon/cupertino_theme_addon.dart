import 'package:flutter/cupertino.dart';
import 'package:widgetbook/widgetbook.dart';

class CupertinoThemeAddon extends ThemeAddon<CupertinoThemeData> {
  CupertinoThemeAddon({
    required ThemeSetting<CupertinoThemeData> themeSetting,
  }) : super(setting: themeSetting);
}

extension CupertinoThemeExtension on BuildContext {
  CupertinoThemeData get cupertinoTheme => theme<CupertinoThemeData>();
}
