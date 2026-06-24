import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/knobs/knobs.dart';
import 'package:widgetbook/widgetbook.dart' show DurationUnit;

import '../../helper/helper.dart';

void main() {
  group(
    '$DurationKnob',
    () {
      testWidgets(
        'given no initial value, '
        'when field is updated, '
        'then the value should be updated',
        (tester) async {
          await tester.pumpKnob(
            (context) {
              final durationValue = context.knobs.durationOrNull(
                label: 'DurationKnob',
              );
              return Text(
                (durationValue?.inMilliseconds).toString(),
              );
            },
          );

          expect(find.textWidget('0'), findsNothing);

          await tester.findAndTap(find.byType(Checkbox));
          expect(find.textWidget('0'), findsOneWidget);

          await tester.findAndTap(find.byType(Checkbox));
          expect(find.textWidget('0'), findsNothing);
        },
      );

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

          final textFields = find.byType(TextField);
          expect(textFields, findsNWidgets(3));

          await tester.enterText(textFields.at(2), '10');
          await tester.pumpAndSettle();

          expect(
            find.textWidget('${tenSeconds.inMilliseconds}'),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'given the days unit is enabled, '
        'then four input fields should be displayed',
        (tester) async {
          await tester.pumpKnob(
            (context) => Text(
              context.knobs
                  .duration(
                    label: 'DurationKnob',
                    units: const {
                      DurationUnit.days,
                      DurationUnit.hours,
                      DurationUnit.minutes,
                      DurationUnit.seconds,
                    },
                  )
                  .inMilliseconds
                  .toString(),
            ),
          );

          expect(find.byType(TextField), findsNWidgets(4));
        },
      );

      testWidgets(
        'given the milliseconds and microseconds units are enabled, '
        'then five input fields should be displayed',
        (tester) async {
          await tester.pumpKnob(
            (context) => Text(
              context.knobs
                  .duration(
                    label: 'DurationKnob',
                    units: const {
                      DurationUnit.hours,
                      DurationUnit.minutes,
                      DurationUnit.seconds,
                      DurationUnit.milliseconds,
                      DurationUnit.microseconds,
                    },
                  )
                  .inMilliseconds
                  .toString(),
            ),
          );

          expect(find.byType(TextField), findsNWidgets(5));
        },
      );

      testWidgets(
        'given only the seconds unit is enabled, '
        'then one input field (seconds) should be displayed',
        (tester) async {
          await tester.pumpKnob(
            (context) => Text(
              context.knobs
                  .duration(
                    label: 'DurationKnob',
                    units: const {DurationUnit.seconds},
                  )
                  .inMilliseconds
                  .toString(),
            ),
          );

          expect(find.byType(TextField), findsNWidgets(1));
        },
      );

      testWidgets(
        'given the days unit is enabled and the days field is edited, '
        'then the emitted duration includes the days component',
        (tester) async {
          await tester.pumpKnob(
            (context) => Text(
              context.knobs
                  .duration(
                    label: 'DurationKnob',
                    units: const {
                      DurationUnit.days,
                      DurationUnit.hours,
                      DurationUnit.minutes,
                      DurationUnit.seconds,
                    },
                  )
                  .inMilliseconds
                  .toString(),
            ),
          );

          final textFields = find.byType(TextField);
          expect(textFields, findsNWidgets(4));

          await tester.enterText(textFields.first, '2');
          await tester.pumpAndSettle();

          expect(
            find.textWidget('${const Duration(days: 2).inMilliseconds}'),
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

    testWidgets(
      'given an initial value with defaultToNull=true, '
      'then the value should initially be null with checkbox unchecked',
      (tester) async {
        const initialValue = Duration(seconds: 5);

        await tester.pumpKnob(
          (context) {
            final durationValue = context.knobs.durationOrNull(
              label: 'Knob',
              initialValue: initialValue,
              defaultToNull: true,
            );
            return Text(
              (durationValue?.inMilliseconds ?? -1).toString(),
            );
          },
        );

        expect(find.textWidget('-1'), findsOneWidget);

        final checkbox = tester.widget<Checkbox>(find.byType(Checkbox));
        expect(checkbox.value, false);

        await tester.findAndTap(find.byType(Checkbox));
        expect(
          find.textWidget('${initialValue.inMilliseconds}'),
          findsOneWidget,
        );
      },
    );
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
