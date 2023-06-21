import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/knobs/knobs.dart';

import 'knob_helper.dart';

void main() {
  const textFinderKey = Key('multilineKnobKey');
  const initialTextValue = '''
// Headers
for (var level = 1; level <= 6; level++)
  AppHeaderBlot(
    level: level,
    child: defaultText,
  ),
''';

  group('$StringKnob', () {
    testWidgets(
      'is multiline',
      (tester) async {
        await tester.pumpWithKnob(
          (context) => Text(
            key: textFinderKey,
            context.knobs.string(
              label: 'label',
              initialValue: initialTextValue,
              maxLines: null,
            ),
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
      (tester) async {
        await tester.pumpWithKnob(
          (context) => Text(
            context.knobs.string(
              label: 'label',
              initialValue: initialTextValue,
            ),
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
