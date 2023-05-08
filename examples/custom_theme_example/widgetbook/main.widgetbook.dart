import 'package:custom_theme_example/main.dart';
import 'package:custom_theme_example/themes/app_theme.dart';
import 'package:custom_theme_example/widgets/awesome_widget.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  runApp(const HotReload());
}

class HotReload extends StatelessWidget {
  const HotReload({super.key});

  @override
  Widget build(BuildContext context) {
    final widgetbookTheme = WidgetbookTheme(
      data: themeDataBlue,
      name: 'Blue',
    );

    final widgetbookTheme2 = WidgetbookTheme(
      data: themeDataYellow,
      name: 'Yellow',
    );

    final devices = [
      Devices.ios.iPhoneSE,
      Devices.ios.iPhone12,
      DeviceInfo.genericPhone(
        platform: TargetPlatform.iOS,
        id: 'Test',
        name: 'Test',
        screenSize: Size(400, 800),
        pixelRatio: 1,
      ),
    ];

    return Widgetbook(
      addons: [
        DeviceAddon(
          devices: devices,
        ),
        ThemeAddon<AppThemeData>(
          themes: [widgetbookTheme, widgetbookTheme2],
          themeBuilder: (_, theme, child) {
            return AppTheme(
              data: theme,
              child: child,
            );
          },
        ),
      ],
      directories: [
        WidgetbookCategory(
          name: 'Default',
          children: [
            WidgetbookComponent(
              name: 'Awesome Widget',
              useCases: [
                WidgetbookUseCase(
                  name: 'Default',
                  builder: (context) => const AwesomeWidget(),
                )
              ],
            ),
            WidgetbookComponent(
              name: 'App Launch Screen',
              useCases: [
                WidgetbookUseCase(
                  name: 'Default',
                  builder: (context) => const MyHomePage(),
                )
              ],
            ),
          ],
        )
      ],
      appBuilder: (context, child) => Container(
        child: child,
      ),
    );
  }
}
