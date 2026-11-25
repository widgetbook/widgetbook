import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  const values = ['a', 'b'];

  group('$IterableArg', () {
    test(
      'given an arg changed to another value, '
      'when its URL value is missing, '
      'then its value is the initial value',
      () {
        final arg = IterableArg(const ['b'], name: 'iterable', values: values);
        arg.syncValue(arg.valueToQueryGroup(const ['a']));

        arg.syncValue(QueryGroup.empty);

        expect(arg.value, ['b']);
      },
    );
  });

  group('$NullableIterableArg', () {
    test(
      'given an arg left at its initial value, '
      'when it is nullified, '
      'then its field shows the initial value',
      () {
        final arg = NullableIterableArg(
          const ['b'],
          name: 'iterable',
          values: values,
        );

        arg.syncValue(QueryGroup.nullified);

        expect(arg.field.valueFrom(QueryGroup.nullified), ['b']);
      },
    );

    test(
      'given a nullified arg left at its initial value, '
      'when it is un-nullified, '
      'then its value is the initial value',
      () {
        final arg = NullableIterableArg(
          const ['b'],
          name: 'iterable',
          values: values,
        );
        arg.syncValue(QueryGroup.nullified);

        arg.syncValue(QueryGroup.nullified.unnullify());

        expect(arg.value, ['b']);
      },
    );

    test(
      'given a nullified arg changed to another value, '
      'when it is un-nullified, '
      'then its value is the changed value',
      () {
        final arg = NullableIterableArg(
          const ['b'],
          name: 'iterable',
          values: values,
        );
        final group = arg.valueToQueryGroup(const ['a']).nullify();
        arg.syncValue(group);

        arg.syncValue(group.unnullify());

        expect(arg.value, const ['a']);
      },
    );

    test(
      'given an arg changed to another value, '
      'when it is nullified, '
      'then its field shows the changed value',
      () {
        final arg = NullableIterableArg(
          const ['b'],
          name: 'iterable',
          values: values,
        );
        final group = arg.valueToQueryGroup(const ['a']).nullify();

        arg.syncValue(group);

        expect(arg.field.valueFrom(group), const ['a']);
      },
    );
  });
}
