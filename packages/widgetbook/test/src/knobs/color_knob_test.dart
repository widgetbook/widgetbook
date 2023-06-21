import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/knobs/knobs.dart';

import 'knob_helper.dart';

void main() {
  group('$ColorKnob', () {
    testWidgets(
      'can return initial value',
      (tester) async {
        await tester.pumpWithKnob(
          (context) => Icon(
            key: const Key('coloredIcon'),
            Icons.thumb_up_sharp,
            color: context.knobs.color(
              label: 'Color',
              initialValue: Colors.blue,
            ),
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
