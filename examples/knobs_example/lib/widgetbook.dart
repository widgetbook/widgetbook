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
    return Widgetbook.material(
      addons: [
        DeviceAddon(
          devices: [
            Devices.ios.iPhoneSE,
            Devices.ios.iPhone12,
          ],
        ),
        TextScaleAddon(
          scales: [1, 2],
        ),
        MaterialThemeAddon(
          themes: [
            WidgetbookTheme(
              data: ThemeData.dark(),
              name: 'dark',
            ),
          ],
        ),
      ],
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
