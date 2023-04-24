import 'package:flutter/cupertino.dart';
import 'package:widgetbook/widgetbook.dart';

class CupertinoThemeAddon extends ThemeAddon<CupertinoThemeData> {
  CupertinoThemeAddon({
    required List<WidgetbookTheme<CupertinoThemeData>> themes,
  }) : super(
          initialSetting: CupertinoThemeSetting(
            themes: themes,
            activeTheme: themes.first,
          ),
        );

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
