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
    return Widgetbook(
      devices: const [
        Apple.iPhone11,
      ],
      themes: [
        WidgetbookTheme(data: ThemeData.dark(), name: 'dark'),
      ],
      textScaleFactors: const [
        1,
        2,
      ],
      categories: [
        WidgetbookCategory(
          name: 'Pages',
          widgets: [
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
                    iconData: context.knobs.options(label: 'Icon', options: [
                      const Option(
                        label: 'Cross',
                        value: Icons.add,
                      ),
                      const Option(
                        label: 'Square',
                        value: Icons.crop_square_sharp,
                      ),
                      const Option(
                        label: 'Circle',
                        value: Icons.circle,
                      ),
                    ]),
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
      appInfo: AppInfo(name: 'Meal App'),
    );
  }
}
