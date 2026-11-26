import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  final initialDate = DateTime(2026, 6);

  group('$DateTimeArg', () {
    test(
      'given an arg changed to another value, '
      'when its URL value is missing, '
      'then its value is the initial value',
      () {
        final arg = DateTimeArg(initialDate, name: 'date');
        arg.syncValue(arg.valueToQueryGroup(DateTime(2040, 6)));

        arg.syncValue(QueryGroup.empty);

        expect(arg.value, initialDate);
      },
    );

    test(
      'given an arg without a range, '
      'when its value changes, '
      'then its range is around the changed value',
      () {
        final arg = DateTimeArg(initialDate, name: 'date');

        arg.syncValue(arg.valueToQueryGroup(DateTime(2030, 6)));

        final field = arg.field as DateTimeField;
        expect(
          (field.start, field.end),
          (DateTime(2029, 6), DateTime(2031, 6)),
        );
      },
    );
  });

  group('$NullableDateTimeArg', () {
    test(
      'given an arg left at its initial value, '
      'when it is nullified, '
      'then its field shows the initial value',
      () {
        final arg = NullableDateTimeArg(initialDate, name: 'date');

        arg.syncValue(QueryGroup.nullified);

        expect(arg.field.valueFrom(QueryGroup.nullified), initialDate);
      },
    );

    test(
      'given a nullified arg left at its initial value, '
      'when it is un-nullified, '
      'then its value is the initial value',
      () {
        final arg = NullableDateTimeArg(initialDate, name: 'date');
        arg.syncValue(QueryGroup.nullified);

        arg.syncValue(QueryGroup.nullified.unnullify());

        expect(arg.value, initialDate);
      },
    );

    test(
      'given a nullified arg changed to another value, '
      'when it is un-nullified, '
      'then its value is the changed value',
      () {
        final arg = NullableDateTimeArg(initialDate, name: 'date');
        final group = arg.valueToQueryGroup(DateTime(2040, 6)).nullify();
        arg.syncValue(group);

        arg.syncValue(group.unnullify());

        expect(arg.value, DateTime(2040, 6));
      },
    );

    test(
      'given an arg changed to another value, '
      'when it is nullified, '
      'then its field shows the changed value',
      () {
        final arg = NullableDateTimeArg(initialDate, name: 'date');
        final group = arg.valueToQueryGroup(DateTime(2040, 6)).nullify();

        arg.syncValue(group);

        expect(arg.field.valueFrom(group), DateTime(2040, 6));
      },
    );
  });
}
