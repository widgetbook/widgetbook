import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/knobs/knobs.dart';
import 'package:widgetbook/src/knobs/text_knob.dart';

import '../../helper/widget_test_helper.dart';
import 'knobs_test.dart';

void main() {
  const textFinderKey = Key('multilineKnobKey');
  const initialTextValue = '''
// Headers
for (var level = 1; level <= 6; level++)
  AppHeaderBlot(
    level: level,
    child: defaultText,
  ),''';

  group('$TextKnob', () {
    testWidgets(
      'is multiline',
      (WidgetTester tester) async {
        await tester.pumpWidgetWithMaterialApp(
          renderWithKnobs(
            build: (context) => [
              Text(
                context.knobs.text(
                  label: 'label',
                  initialValue: initialTextValue,
                  maxLines: null,
                ),
                key: textFinderKey,
              )
            ],
          ),
        );

        final textFinder = find.byType(TextField);

        expect(textFinder, findsWidgets);

        final multilineText = textFinder.evaluate().first.widget as TextField;
        expect(multilineText.maxLines, null);
      },
    );

    testWidgets(
      'is not multiline',
      (WidgetTester tester) async {
        await tester.pumpWidgetWithMaterialApp(
          renderWithKnobs(
            build: (context) => [
              Text(
                context.knobs.text(
                  label: 'label',
                  initialValue: initialTextValue,
                ),
              )
            ],
          ),
        );

        final textFinder = find.byType(TextField);

        expect(textFinder, findsWidgets);

        final multilineText = textFinder.evaluate().first.widget as TextField;
        expect(multilineText.maxLines, 1);
      },
    );
  });
}
