import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'components.g.dart';
import 'customs/custom_addon.dart';
import 'customs/custom_theme.dart';

void main() {
  runWidgetbook(
    Config(
      components: components,
      addons: [
        ViewportAddon(Viewports.all),
        GridAddon(100),
        AlignAddon(),
        ZoomAddon(),
        ThemeAddon<AppThemeData>(
          {
            'Blue': AppThemeData(Colors.blue),
            'Yellow': AppThemeData(Colors.yellow),
          },
          (context, theme, child) {
            // Wrap use cases with the custom theme's InheritedWidget
            return AppTheme(
              data: theme,
              child: child,
            );
          },
        ),
      ],
    ),
  );
}
