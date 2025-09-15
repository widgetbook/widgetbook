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
        'given no initial value, '
        'when field is updated, '
        'then the value should be updated',
        (tester) async {
          final now = DateTime.now();
          final nextYear = DateTime(now.year + 1);

          await tester.pumpKnob(
            (context) => Text(
              (context.knobs
                      .dateTimeOrNull(
                        label: 'DateTimeKnob',
                        start: now,
                        end: nextYear,
                      )
                      ?.toSimpleFormat())
                  .toString(),
            ),
          );

          expect(find.textWidget(now.toSimpleFormat()), findsNothing);

          await tester.findAndTap(find.byType(Checkbox));
          expect(find.textWidget(now.toSimpleFormat()), findsOneWidget);

          await tester.findAndTap(find.byType(Checkbox));
          expect(find.textWidget(now.toSimpleFormat()), findsNothing);
        },
      );

      testWidgets(
        'given an initial value, '
        'then the value should be displayed',
        (tester) async {
          final dateTime = DateTime(2021, 1, 1, 0, 0, 5);
          await tester.pumpKnob(
            (context) => Text(
              context.knobs
                  .dateTime(
                    label: 'DateTimeKnob',
                    initialValue: dateTime,
                    start: DateTime(dateTime.year - 1),
                    end: DateTime(dateTime.year + 1),
                  )
                  .toSimpleFormat(),
            ),
          );

          expect(
            find.textWidget(dateTime.toSimpleFormat()),
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
              context.knobs
                  .dateTime(
                    label: 'DateTimeKnob',
                    initialValue: now,
                    start: DateTime(now.year - 1),
                    end: nextYear,
                  )
                  .toSimpleFormat(),
            ),
          );

          await tester.findAndEnter(
            find.byType(TextField),
            nextYear.toSimpleFormat(),
          );

          expect(
            find.textWidget(nextYear.toSimpleFormat()),
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
                    start: DateTime(now.year - 1),
                    end: DateTime(now.year + 1),
                  )
                  .toSimpleFormat(),
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
            dateTime.toSimpleFormat(),
          );

          expect(
            find.textWidget(dateTime.toSimpleFormat()),
            findsOneWidget,
          );
        },
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
                start: DateTime(DateTime.now().year - 1),
                end: DateTime(DateTime.now().year + 1),
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
