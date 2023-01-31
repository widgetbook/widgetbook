import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/knobs/color_knob.dart';
import 'package:widgetbook/src/knobs/knobs.dart';

import '../../helper/widget_test_helper.dart';
import 'knobs_test.dart';

void main() {
  group('$ColorKnob', () {
    testWidgets(
      'can return initial value',
      (WidgetTester tester) async {
        await tester.pumpWidgetWithMaterialApp(
          renderWithKnobs(
            build: (context) => [
              Icon(
                Icons.thumb_up_sharp,
                color: context.knobs.color(
                  label: 'Color',
                  initialValue: Colors.blue,
                ),
                key: const Key('coloredIcon'),
              )
            ],
          ),
        );

        final iconFinder = find.byKey(
          const Key('coloredIcon'),
        );

        expect(iconFinder, findsWidgets);

        final icon = iconFinder.evaluate().first.widget as Icon;
        expect(icon.color, Colors.blue);
      },
    );
  });
}
