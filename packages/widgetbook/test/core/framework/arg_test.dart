import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

enum _Priority { low, high }

void main() {
  group('$Arg', () {
    test(
      'given a nullable arg left at its initial value, '
      'when it is nullified, '
      'then its field shows the initial value',
      () {
        final arg = NullableStringArg('hello', name: 'label');

        arg.syncValue(QueryGroup.nullified);

        expect(arg.field.valueFrom(QueryGroup.nullified), 'hello');
      },
    );

    test(
      'given a nullified nullable arg left at its initial value, '
      'when it is un-nullified, '
      'then its value is the initial value',
      () {
        final arg = NullableStringArg('hello', name: 'label');
        arg.syncValue(QueryGroup.nullified);

        arg.syncValue(QueryGroup.nullified.unnullify());

        expect(arg.value, 'hello');
      },
    );

    test(
      'given a nullified nullable arg changed to another value, '
      'when it is un-nullified, '
      'then its value is the changed value',
      () {
        final arg = NullableStringArg('hello', name: 'label');
        final group = const QueryGroup({'value': 'bye'}).nullify();
        arg.syncValue(group);

        arg.syncValue(group.unnullify());

        expect(arg.value, 'bye');
      },
    );

    test(
      'given an arg synced to a valid value, '
      'when it is synced to an undecodable value, '
      'then its value is the initial value',
      () {
        final arg = IntArg(42, name: 'count');

        arg.syncValue(const QueryGroup({'value': '7'}));
        arg.syncValue(const QueryGroup({'value': 'garbage'}));

        expect(arg.value, 42);
      },
    );

    final changedArgs = <(Arg, Object?)>[
      (BoolArg(true, name: 'bool'), false),
      (NullableBoolArg(true, name: 'bool'), null),
      (
        ColorArg(const Color(0xFF000000), name: 'color'),
        const Color(0xFFFFFFFF),
      ),
      (NullableColorArg(const Color(0xFF000000), name: 'color'), null),
      (DateTimeArg(DateTime(2026), name: 'date'), DateTime(2030)),
      (NullableDateTimeArg(DateTime(2026), name: 'date'), null),
      (DoubleArg(0.5, name: 'double'), 1.5),
      (
        DoubleArg(
          0.5,
          name: 'double',
          style: const SliderDoubleArgStyle(min: 0, max: 2, divisions: 4),
        ),
        1.5,
      ),
      (NullableDoubleArg(0.5, name: 'double'), null),
      (
        DurationArg(const Duration(seconds: 1), name: 'duration'),
        const Duration(seconds: 2),
      ),
      (NullableDurationArg(const Duration(seconds: 1), name: 'duration'), null),
      (IntArg(42, name: 'int'), 7),
      (
        IntArg(
          42,
          name: 'int',
          style: const SliderIntArgStyle(min: 0, max: 100, divisions: 100),
        ),
        7,
      ),
      (NullableIntArg(42, name: 'int'), null),
      (
        IterableArg(const ['a'], name: 'iterable', values: const ['a', 'b']),
        const ['b'],
      ),
      (
        NullableIterableArg(
          const ['a'],
          name: 'iterable',
          values: const ['a', 'b'],
        ),
        null,
      ),
      (
        EnumArg(_Priority.low, name: 'enum', values: _Priority.values),
        _Priority.high,
      ),
      (
        EnumArg(
          _Priority.low,
          name: 'enum',
          values: _Priority.values,
          style: const SegmentedSingleArgStyle(),
        ),
        _Priority.high,
      ),
      (
        NullableEnumArg(_Priority.high, name: 'enum', values: _Priority.values),
        null,
      ),
      (StringArg('hello', name: 'string'), 'bye'),
      (NullableStringArg('hello', name: 'string'), null),
    ];

    for (final (arg, changedValue) in changedArgs) {
      test(
        'given a ${arg.runtimeType} changed to $changedValue, '
        'when its URL value is missing, '
        'then its value is the initial value',
        () {
          arg.syncValue(arg.valueToQueryGroup(changedValue));
          expect(arg.value, changedValue);

          arg.syncValue(QueryGroup.empty);

          expect(arg.value, arg.initialValue);
        },
      );
    }

    test(
      'given a $DateTimeArg without a range, '
      'when its value changes, '
      'then its range stays around the initial value',
      () {
        final arg = DateTimeArg(DateTime(2026, 6), name: 'date');

        arg.syncValue(arg.valueToQueryGroup(DateTime(2040, 6)));
        final field = arg.field as DateTimeField;

        expect(field.start, DateTime(2025, 6));
        expect(field.end, DateTime(2027, 6));
      },
    );
  });
}
