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
            find.widgetWithText(TextFormField, 's'),
            tenSeconds.inSeconds.toString(),
          );

          expect(
            find.textWidget('${tenSeconds.inMilliseconds}'),
            findsOneWidget,
          );
        },
      );
    },
  );

  group('${DurationKnob.nullable}', () {
    test('DurationKnob.nullable constructor sets correct values', () {
      final knob = DurationKnob.nullable(
        label: 'Test Duration',
        initialValue: const Duration(seconds: 5),
        description: 'A test duration knob',
      );

      expect(knob.label, 'Test Duration');
      expect(knob.initialValue, const Duration(seconds: 5));
      expect(knob.description, 'A test duration knob');
    });

    test('DurationKnob.nullable constructor handles null value', () {
      final knob = DurationKnob.nullable(
        label: 'Test Duration',
        initialValue: null,
        description: 'A test duration knob with null value',
      );

      expect(knob.label, 'Test Duration');
      expect(knob.initialValue, null);
      expect(knob.description, 'A test duration knob with null value');
    });
  });

  group('$KnobsBuilder', () {
    Duration? mockOnKnobAdded<Duration>(Knob<Duration?> knob) =>
        knob.initialValue;

    final builder = KnobsBuilder(mockOnKnobAdded);

    test('durationOrNull sets correct values', () {
      final duration = builder.durationOrNull(
        label: 'Test Duration',
        initialValue: const Duration(seconds: 10),
        description: 'A test duration',
      );

      expect(duration, const Duration(seconds: 10));
    });

    test('durationOrNull handles null initialValue', () {
      final duration = builder.durationOrNull(
        label: 'Test Duration',
        description: 'A test duration with null value',
      );

      expect(duration, null);
    });
  });
}
