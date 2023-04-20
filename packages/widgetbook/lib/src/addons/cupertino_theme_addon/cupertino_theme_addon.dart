import 'package:flutter/cupertino.dart';
import 'package:widgetbook/widgetbook.dart';

class CupertinoThemeAddon extends ThemeAddon<CupertinoThemeData> {
  CupertinoThemeAddon({
    required super.setting,
  });

  @override
  Widget buildUseCaseWrapper(BuildContext context, Widget child) {
    return CupertinoTheme(
      data: value.activeTheme.data,
      child: child,
    );
  }
}

extension CupertinoThemeExtension on BuildContext {
  CupertinoThemeData? get cupertinoTheme => theme<CupertinoThemeData>();
}
