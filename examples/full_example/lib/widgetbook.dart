import 'package:flutter/material.dart';
import 'package:widgetbook/next.dart' as next;
import 'package:widgetbook/widgetbook.dart';

import 'components.book.dart';
import 'customs/custom_addon.dart';
import 'customs/custom_theme.dart';

void main() {
  runApp(const WidgetbookApp());
}

class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      directories: components,
      addons: [
        DeviceFrameAddon(devices: Devices.ios.all),
        InspectorAddon(),
        GridAddon(100),
        AlignAddon(),
        ZoomAddon(),
        next.ThemeAddon<AppThemeData>(
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
    );
  }
}
