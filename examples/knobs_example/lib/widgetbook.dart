import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'home_page.dart';

void main() {
  runApp(const WidgetbookApp());
}

class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    final initialDate = DateTime.now();

    return Widgetbook.material(
      directories: [
        WidgetbookComponent(
          name: 'HomePage',
          useCases: [
            WidgetbookUseCase(
              name: 'Without Knobs',
              builder: (context) {
                return const HomePage(
                  title: 'Without Knobs',
                );
              },
            ),
            WidgetbookUseCase(
              name: 'With Knobs',
              builder: (context) {
                return HomePage(
                  title: context.knobs.string(
                    label: 'Title',
                    initialValue: 'With Knobs',
                  ),
                  incrementBy: context.knobs.doubleOrNull
                          .slider(
                            label: 'Increment By',
                            min: 0,
                            initialValue: 5,
                            max: 10,
                            divisions: 10,
                          )
                          ?.toInt() ??
                      0,
                  countLabel: context.knobs.stringOrNull(
                    initialValue: 'Current Count',
                    label: 'Count Label',
                    description: 'This is the text that appears '
                        'above the current count of increments',
                  ),
                  iconData: context.knobs.list(
                    label: 'Icon',
                    options: [
                      Icons.add,
                      Icons.crop_square_sharp,
                      Icons.circle,
                    ],
                  ),
                  showToolTip: context.knobs.boolean(
                    initialValue: true,
                    label: 'Show Increment Tool Tip',
                    description: 'This is the tooltip that is displayed '
                        'when hovering over the increment button',
                  ),
                  duration: context.knobs.duration(
                    label: 'Increment duration',
                    initialValue: const Duration(seconds: 5),
                  ),
                  dateTime: context.knobs.dateTimeOrNull(
                    // placing DateTime.now() here will cause the date time and
                    // the text field to be out of sync
                    initialValue: initialDate,
                    label: 'Select Date Time',
                    readOnly: false,
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
