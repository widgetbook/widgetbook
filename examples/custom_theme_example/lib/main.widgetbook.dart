import 'package:custom_theme_example/app_theme.dart';
import 'package:custom_theme_example/awesome_widget.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  runApp(const HotReload());
}

AppThemeData themeData = AppThemeData(
  color: Colors.yellow,
  typography: TypographyData(123),
);

class HotReload extends StatelessWidget {
  const HotReload({super.key});

  @override
  Widget build(BuildContext context) {
    final widgetbookTheme = WidgetbookTheme(
      data: themeData,
      name: 'App Theme',
    );

    return Widgetbook(
      addons: [
        CustomThemeAddon<AppThemeData>(
          themeSetting: CustomThemeSetting<AppThemeData>(
            themes: [
              widgetbookTheme,
            ],
            activeThemes: {
              widgetbookTheme,
            },
          ),
        ),
        DeviceAddon(data: DeviceSelection()),
      ],
      appInfo: AppInfo(name: 'Custom Theme Example'),
      categories: [
        WidgetbookCategory(
          name: 'Default',
          widgets: [
            WidgetbookComponent(
              name: 'Awesome Widget',
              useCases: [
                WidgetbookUseCase(
                  name: 'Default',
                  builder: (context) => const AwesomeWidget(),
                )
              ],
            ),
          ],
        )
      ],
      appBuilder: (context, child) {
        // This is actually important
        return AppTheme(
          data: context.theme(),
          child: WidgetsApp(
            // This is not so important
            color: context.theme().backgroundColor,
            home: child,
          ),
        );
      },
    );
  }
}
