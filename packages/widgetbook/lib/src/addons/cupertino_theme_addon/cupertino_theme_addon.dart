import 'package:flutter/cupertino.dart';
import 'package:widgetbook/widgetbook.dart';

class CupertinoThemeAddon extends ThemeAddon<CupertinoThemeData> {
  CupertinoThemeAddon({
    required super.initialSetting,
  });

  @override
  Widget buildUseCase(BuildContext context, Widget child) {
    return CupertinoTheme(
      data: setting.activeTheme.data,
      child: child,
    );
  }
}

extension CupertinoThemeExtension on BuildContext {
  CupertinoThemeData? get cupertinoTheme => theme<CupertinoThemeData>();
}
