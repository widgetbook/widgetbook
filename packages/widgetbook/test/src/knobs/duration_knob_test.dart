import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/knobs/knobs.dart';

import '../../helper/helper.dart';

void main() {
  group(
    '$DurationKnob',
    () {
      testWidgets(
        'given an initial value, '
        'then the value should be displayed',
        (tester) async {
          const fiveSeconds = Duration(seconds: 5);

          await tester.pumpKnob(
            (context) {
              final durationValue = context.knobs.duration(
                label: 'DurationKnob',
                initialValue: fiveSeconds,
              );
              return Text(
                durationValue.inMilliseconds.toString(),
              );
            },
          );

          expect(
            find.textWidget('${fiveSeconds.inMilliseconds}'),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'when field is updated, '
        'then the value should be updated',
        (tester) async {
          const fiveSeconds = Duration(seconds: 5);
          const tenSeconds = Duration(seconds: 10);

          await tester.pumpKnob(
            (context) => Text(
              context.knobs
                  .duration(
                    label: 'DurationKnob',
                    initialValue: fiveSeconds,
                  )
                  .inMilliseconds
                  .toString(),
            ),
          );

          await tester.findAndEnter(
            find.byType(TextField),
            tenSeconds.inMilliseconds.toString(),
          );

          expect(
            find.textWidget('${tenSeconds.inMilliseconds}'),
            findsOneWidget,
          );
        },
      );
    },
  );
}
