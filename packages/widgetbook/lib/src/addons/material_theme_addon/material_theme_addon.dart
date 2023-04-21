import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

class MaterialThemeAddon extends ThemeAddon<ThemeData> {
  MaterialThemeAddon({
    required super.setting,
  });

  @override
  Widget buildUseCase(BuildContext context, Widget child) {
    return Theme(
      data: value.activeTheme.data,
      child: child,
    );
  }
}

extension MaterialThemeExtension on BuildContext {
  ThemeData? get materialTheme => theme<ThemeData>();
}
