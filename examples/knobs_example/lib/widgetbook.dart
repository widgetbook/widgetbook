import 'package:flutter/material.dart';
import 'package:knobs_example/main.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  runApp(const KnobsExample());
}

class KnobsExample extends StatelessWidget {
  const KnobsExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final devices = [
      Apple.iPhone11,
      Apple.iPhone12,
    ];
    final deviceFrameBuilder = DefaultDeviceFrame(
      setting: DeviceSetting.firstAsSelected(devices: devices),
    );

    final activeFrameBuilder = WidgetbookFrame(
      setting: DeviceSetting.firstAsSelected(devices: devices),
    );

    return Widgetbook.material(
      addons: [
        FrameAddon(
          setting: FrameSetting.firstAsSelected(
            frames: [
              deviceFrameBuilder,
              NoFrame(),
              activeFrameBuilder,
            ],
          ),
        ),
        TextScaleAddon(
          setting: TextScaleSetting.firstAsSelected(
            textScales: [1, 2],
          ),
        ),
        CustomThemeAddon<ThemeData>(
          setting: CustomThemeSetting.firstAsSelected(
            themes: [
              WidgetbookTheme(data: ThemeData.dark(), name: 'dark'),
            ],
          ),
        ),
      ],
      appBuilder: (context, child) {
        final frameBuilder = context.frameBuilder;
        final theme = context.theme<ThemeData>();
        return Theme(
          data: theme!,
          child: frameBuilder!(context, child),
        );
      },
      directories: [
        WidgetbookCategory(
          name: 'Pages',
          children: [
            WidgetbookComponent(
              name: 'On boarding',
              useCases: [
                WidgetbookUseCase(
                  name: 'Home Page',
                  builder: (context) => MyHomePage(
                    title: context.knobs
                        .text(label: 'Title', initialValue: 'Title'),
                    incrementBy: context.knobs
                            .nullableSlider(
                                label: 'Increment By',
                                min: 0,
                                initialValue: 5,
                                max: 10,
                                divisions: 10)
                            ?.toInt() ??
                        0,
                    countLabel: context.knobs.nullableText(
                      label: 'Count Label',
                      initialValue: 'Current Count',
                      description:
                          'This is the text that appears above the current count of increments',
                    ),
                    iconData: context.knobs.options(
                      label: 'Icon',
                      options: [
                        Icons.add,
                        Icons.crop_square_sharp,
                        Icons.circle
                      ],
                    ),
                    showToolTip: context.knobs.boolean(
                      label: 'Show Increment Tool Tip',
                      description:
                          'This is the tooltip that is displayed when hovering over the increment button',
                      initialValue: true,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
