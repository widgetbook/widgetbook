import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/knobs/knobs.dart';

import '../../helper/helper.dart';

void main() {
  group(
    '$ColorKnob',
    () {
      testWidgets(
        'when field is updated, '
        'then the value should be updated',
        (tester) async {
          const blue = Color(0xFF0000FF);
          const red = Color(0xFFFF0000);

          await tester.pumpKnob(
            (context) => ColoredBox(
              color: context.knobs.color(
                label: 'Knob',
                initialValue: blue,
              ),
            ),
          );

          await tester.findAndEnter(
            find.byType(TextField),
            'FFFF0000',
          );

          final box = tester.widget<ColoredBox>(find.byType(ColoredBox));

          expect(box.color, equals(red));
        },
      );
    },
  );
}
