import 'package:addon_example/sound_addon/sound_addon_setting.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'sound_addon/sound_addon.dart';

void main(List<String> args) {
  runApp(const HotReload());
}

class HotReload extends StatelessWidget {
  const HotReload({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      directories: [
        WidgetbookComponent(
          name: 'Comp',
          useCases: [
            WidgetbookUseCase(
              name: 'Use-case',
              builder: (context) {
                return Text('The sound is: ${context.isSoundEnabled}');
              },
            )
          ],
        ),
      ],
      addons: [
        MaterialThemeAddon(
          setting: ThemeSetting.firstAsSelected(
            themes: [
              WidgetbookTheme(name: 'Dark', data: ThemeData.dark()),
              WidgetbookTheme(name: 'Light', data: ThemeData.light()),
            ],
          ),
        ),
        FrameAddon(
          setting: FrameSetting.firstAsSelected(
            frames: [
              NoFrame(),
              DefaultDeviceFrame(
                setting: DeviceSetting.firstAsSelected(
                  devices: [
                    Apple.iPhone13,
                  ],
                ),
              ),
              WidgetbookFrame(
                setting: DeviceSetting.firstAsSelected(
                  devices: [
                    Apple.iPhone13,
                  ],
                ),
              )
            ],
          ),
        ),
        SoundAddon(setting: const SoundAddonSetting(isEnabled: true)),
      ],
    );
  }
}
