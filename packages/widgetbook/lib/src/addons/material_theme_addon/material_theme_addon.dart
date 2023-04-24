import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

class MaterialThemeAddon extends ThemeAddon<ThemeData> {
  MaterialThemeAddon({
    required super.initialSetting,
  });

  @override
  Widget buildUseCase(BuildContext context, Widget child) {
    return Theme(
      data: setting.activeTheme.data,
      child: child,
    );
  }
}

extension MaterialThemeExtension on BuildContext {
  ThemeData? get materialTheme => theme<ThemeData>();
}
