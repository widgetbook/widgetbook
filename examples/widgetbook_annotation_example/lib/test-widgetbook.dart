import 'package:flutter/material.dart';
import 'package:meal_app/themes/dark_theme.dart';
import 'package:meal_app/themes/light_theme.dart';
import 'package:widgetbook/widgetbook.dart';

import 'app.dart';

void main() {
  runApp(HotReload());
}

class HotReload extends StatelessWidget {
  const HotReload({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      appInfo: AppInfo(
        name: 'Test App',
      ),
      addons: [
        CustomThemeAddon<ThemeData>(
          setting: ThemeSetting<ThemeData>.firstAsSelected(
            themes: [
              WidgetbookTheme(
                name: 'Dark',
                data: getDarkThemeData(),
              ),
              WidgetbookTheme(
                name: 'Light',
                data: getLightThemeData(),
              ),
            ],
          ),
        ),
        TextScaleAddon(
          setting: TextScaleSetting.firstAsSelected(
            textScales: [
              1.0,
              2.0,
              3.0,
            ],
          ),
        ),
        LocalizationAddon(
          setting: LocalizationSetting(
            locales: locales,
            activeLocale: locales.first,
            localizationsDelegates: delegates,
          ),
        ),
        FrameAddon(
          setting: FrameSetting.firstAsSelected(
            frames: [
              WidgetbookFrame(
                setting: DeviceSetting.firstAsSelected(
                  devices: [Apple.iPhone12],
                ),
              ),
              NoFrame(),
              DefaultDeviceFrame(
                setting: DeviceSetting.firstAsSelected(
                  devices: [Apple.iPhone12],
                ),
              ),
            ],
          ),
        ),
      ],
      children: [
        WidgetbookComponent(
          name: 'Test Component',
          isInitiallyExpanded: true,
          useCases: [
            WidgetbookUseCase(
              name: 'Test Use Case',
              builder: (context) => const TestWidget(),
            ),
          ],
        ),
        WidgetbookCategory(
          name: 'Test Category',
          children: [
            WidgetbookFolder(
              name: 'Test Folder',
              isInitiallyExpanded: true,
              children: [
                WidgetbookComponent(
                  name: 'Test Component',
                  isInitiallyExpanded: true,
                  useCases: [
                    WidgetbookUseCase(
                      name: 'Test Use Case 1',
                      builder: (context) =>
                          const TestWidget(text: 'Test Widget 1'),
                    ),
                  ],
                ),
                WidgetbookComponent(
                  name: 'Test Component',
                  isInitiallyExpanded: true,
                  useCases: [
                    WidgetbookUseCase(
                      name: 'Test Use Case 2',
                      builder: (context) =>
                          const TestWidget(text: 'Test Widget 2'),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class TestWidget extends StatelessWidget {
  const TestWidget({
    super.key,
    this.text = 'Test Widget',
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(text)),
    );
  }
}
