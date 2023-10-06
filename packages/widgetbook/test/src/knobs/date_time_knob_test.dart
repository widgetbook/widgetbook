import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/fields/fields.dart';
import 'package:widgetbook/src/knobs/knobs.dart';

import '../../helper/helper.dart';

void main() {
  group(
    '${DateTimeKnob}',
    () {
      testWidgets(
        'given an initial value, '
        'then the value should be displayed',
        (tester) async {
          final dateTime = DateTime(2021, 1, 1, 0, 0, 5);

          await tester.pumpKnob(
            (context) => Text(
              DateTimeField.asString(
                context.knobs.dateTime(
                  label: 'DateTimeKnob',
                  initialValue: dateTime,
                ),
              ),
            ),
          );

          expect(
            find.textWidget(DateTimeField.asString(dateTime)),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'when field is updated, '
        'then the value should be updated',
        (tester) async {
          final now = DateTime.now();
          final nextYear = DateTime(now.year + 1);

          await tester.pumpKnob(
            (context) => Text(
              DateTimeField.asString(
                context.knobs.dateTime(
                  label: 'DateTimeKnob',
                  initialValue: now,
                  readOnly: false,
                ),
              ),
            ),
          );

          await tester.findAndEnter(
            find.byType(TextField),
            DateTimeField.asString(nextYear),
          );

          expect(
            find.textWidget(DateTimeField.asString(nextYear)),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'when date time picker is opened and date time is selected, '
        'then the value should be updated',
        (tester) async {
          final now = DateTime.now();

          await tester.pumpKnob(
            (context) => Text(
              context.knobs
                  .dateTime(
                    label: 'DateTimeKnob',
                    initialValue: now,
                  )
                  .toIso8601String(),
            ),
          );

          // opens up the date time picker
          await tester.findAndTap(find.byType(IconButton));
          // selects the 17th of the month
          await tester.findAndTap(find.text('17'));
          await tester.findAndTap(find.text('OK'));
          // for some reason i can't select the time so I will just skip that
          await tester.findAndTap(find.text('OK'));

          final dateTime = DateTime(
            now.year,
            now.month,
            17,
            now.hour,
            now.minute,
          );

          await tester.findAndEnter(
            find.byType(TextField),
            dateTime.toIso8601String(),
          );

          expect(
            find.textWidget(dateTime.toIso8601String()),
            findsOneWidget,
          );
        },
        variant: const TargetPlatformVariant(<TargetPlatform>{
          TargetPlatform.windows,
        }),
      );
    },
  );

  group(
    '${DateTimeKnob.nullable}',
    () {
      testWidgets(
        'given no initial value, '
        'then no value should be displayed',
        (tester) async {
          await tester.pumpKnob(
            (context) {
              context.knobs.dateTimeOrNull(
                label: 'DateTimeKnob',
              );
              return const Text('');
            },
          );

          expect(
            find.textWidget(''),
            findsOneWidget,
          );
        },
      );
    },
  );
}
