import 'package:custom_theme_example/app_theme.dart';
import 'package:custom_theme_example/awesome_widget.dart';
import 'package:custom_theme_example/main.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as anno;

void main() {
  runApp(const HotReload());
}

@anno.WidgetbookTheme(name: 'Default')
AppThemeData themeData = AppThemeData(
  color: Colors.blue,
);
@anno.WidgetbookTheme(name: 'Appthem2')
AppThemeData themeData2 = AppThemeData(
  color: Colors.yellow,
);

class HotReload extends StatelessWidget {
  const HotReload({super.key});

  @override
  Widget build(BuildContext context) {
    final widgetbookTheme = WidgetbookTheme(
      data: themeData,
      name: 'App Theme',
    );
    final widgetbookTheme2 = WidgetbookTheme(
      data: themeData2,
      name: 'App Theme2',
    );
    final devices = [
      Apple.iPhone11,
      Apple.iPhone12,
      const Device.special(
        name: 'Test',
        resolution: Resolution(
          nativeSize: DeviceSize(width: 400, height: 400),
          scaleFactor: 1,
        ),
      ),
    ];
    final deviceFrameBuilder = DefaultDeviceFrame(
      setting: DeviceSetting.firstAsSelected(devices: devices),
    );

    final activeFrameBuilder = WidgetbookFrame(
      setting: DeviceSetting.firstAsSelected(devices: devices),
    );

    return Widgetbook(
        addons: [
          FrameAddon(
              setting: FrameSetting.firstAsSelected(frames: [
            deviceFrameBuilder,
            NoFrame(),
            activeFrameBuilder,
          ])),
          CustomThemeAddon<AppThemeData>(
            themeSetting: CustomThemeSetting.firstAsSelected(
              themes: [widgetbookTheme, widgetbookTheme2],
            ),
          ),
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
        appBuilder: (context, child) {
          final frameBuilder = context.frameBuilder;
          final theme = context.theme<AppThemeData>();
          return AppTheme(
            data: theme,
            child: frameBuilder(context, child),
          );
        });
  }
}
