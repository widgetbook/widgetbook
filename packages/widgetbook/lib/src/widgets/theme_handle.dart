import 'package:flutter/material.dart';
import 'package:widgetbook/src/providers/theme_provider.dart';
import 'package:widgetbook/src/utils/extensions.dart';

class ThemeHandle extends StatelessWidget {
  const ThemeHandle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeProvider = ThemeProvider.of(context)!;
    return Row(
      children: [
        // TODO add an own widget for this
        // or style the text button.icon appropriately
        // TODO make sure the onPresses is triggered on the text as well
        TextButton(
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
        const SizedBox(
          width: 4,
        ),
        const Text('theme'),
      ],
    );
  }
}
