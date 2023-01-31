import 'package:flutter/cupertino.dart';
import 'package:widgetbook/widgetbook.dart';

class CupertinoThemeAddon extends ThemeAddon<CupertinoThemeData> {
  CupertinoThemeAddon({
    required super.setting,
  });
}

extension CupertinoThemeExtension on BuildContext {
  CupertinoThemeData? get cupertinoTheme => theme<CupertinoThemeData>();
}
