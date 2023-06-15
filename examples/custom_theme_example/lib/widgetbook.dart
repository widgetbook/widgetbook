import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'app_theme.dart';
import 'awesome_widget.dart';

void main() {
  runApp(const WidgetbookApp());
}

class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook(
      addons: [
        ThemeAddon<AppThemeData>(
          themes: [
            WidgetbookTheme(
              name: 'Blue',
              data: AppThemeData(
                color: Colors.blue,
              ),
            ),
            WidgetbookTheme(
              name: 'Yellow',
              data: AppThemeData(
                color: Colors.yellow,
              ),
            ),
          ],
          themeBuilder: (context, theme, child) {
            // Wrap use cases with the custom theme's InheritedWidget
            return AppTheme(
              data: theme,
              child: child,
            );
          },
        ),
      ],
      directories: [
        WidgetbookComponent(
          name: 'Awesome Widget',
          useCases: [
            WidgetbookUseCase(
              name: 'Default',
              builder: (context) => const AwesomeWidget(),
            )
          ],
        )
      ],
      appBuilder: (context, child) {
        // Wrap all uses cases with a custom app widget, since
        // we are not using [MaterialApp] from [Widgetbook.material]
        return Container(
          child: child,
        );
      },
    );
  }
}
