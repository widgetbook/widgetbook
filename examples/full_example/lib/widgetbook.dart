/// A complete example for Widgetbook manual approach
///
/// Use [WidgetbookFolder],[WidgetbookComponent], and [WidgetbookUseCase]
/// to create directories
/// [Ref link]: https://docs.widgetbook.io/guides/complete-example
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart' hide AlignmentAddon;

import 'components/container.dart';
import 'components/custom_card.dart';
import 'components/custom_text_field.dart';
import 'customs/custom_addon.dart';
import 'customs/custom_knob.dart';

void main() {
  runApp(const WidgetbookApp());
}

class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      addons: [
        ViewportAddon(Viewports.all),
        InspectorAddon(),
        GridAddon(100),
        AlignmentAddon(),
        ZoomAddon(),
      ],
      directories: [
        WidgetbookFolder(
          name: 'Widgets',
          children: [
            WidgetbookComponent(
              name: 'CustomContainer',
              useCases: [
                WidgetbookUseCase(
                  name: 'Default Style',
                  builder: (context) => greenContainerUseCase(context),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'CustomCard',
              useCases: [
                WidgetbookUseCase(
                  name: 'Default Style',
                  builder: (context) => const CustomCard(
                    child: Text('This is a custom card'),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'With Custom Background Color',
                  builder: (context) => CustomCard(
                    backgroundColor: Colors.green.shade100,
                    child: const Text(
                      'This is a custom card with a custom background color',
                    ),
                  ),
                ),
              ],
            ),
            // CustomTextField component use-cases
            WidgetbookComponent(
              name: 'CustomTextField',
              useCases: [
                WidgetbookUseCase(
                  name: 'Default Style',
                  builder: (context) => CustomTextField(
                    controller: TextEditingController(),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'With Hint Text',
                  builder: (context) => CustomTextField(
                    controller: TextEditingController(),
                    hintText: 'Enter your text here',
                  ),
                ),
              ],
            ),
          ],
        ),
        WidgetbookFolder(
          name: 'knobs',
          children: [
            WidgetbookComponent(
              name: 'RangeSlider',
              useCases: [
                WidgetbookUseCase(
                  name: 'Default',
                  builder: (context) => rangeSlider(context),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
