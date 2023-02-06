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
            setting: CustomThemeSetting.firstAsSelected(
              themes: [widgetbookTheme, widgetbookTheme2],
            ),
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
        appBuilder: (context, child) {
          final frameBuilder = context.frameBuilder;
          final theme = context.theme<AppThemeData>();
          return AppTheme(
            data: theme!,
            child: frameBuilder!(context, child),
          );
        });
  }
}
