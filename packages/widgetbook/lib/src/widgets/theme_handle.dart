import 'package:flutter/material.dart';
import 'package:widgetbook/src/providers/theme_provider.dart';
import 'package:widgetbook/src/utils/extensions.dart';

class ThemeHandle extends StatelessWidget {
  const ThemeHandle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = ThemeProvider.of(context)!;
    return Tooltip(
      message: 'Toggle theme',
      child: TextButton(
        onPressed: themeProvider.toggleTheme,
        style: TextButton.styleFrom(
          splashFactory: InkRipple.splashFactory,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(90)),
          minimumSize: Size.zero,
          padding: const EdgeInsets.all(12),
        ),
        child: Icon(
          Icons.dark_mode,
          color: themeProvider.state == ThemeMode.light
              ? context.theme.hintColor
              : context.colorScheme.primary,
        ),
      ),
    );
  }
}
