import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  const slider = SliderIntArgStyle(min: 0, max: 100, divisions: 100);

  group('$IntArg', () {
    test(
      'given an input arg changed to another value, '
      'when its URL value is missing, '
      'then its value is the initial value',
      () {
        final arg = IntArg(42, name: 'int');
        arg.syncValue(arg.valueToQueryGroup(7));

        arg.syncValue(QueryGroup.empty);

        expect(arg.value, 42);
      },
    );

    test(
      'given an input arg changed to another value, '
      'when its URL value is undecodable, '
      'then its value is the initial value',
      () {
        final arg = IntArg(42, name: 'int');
        arg.syncValue(arg.valueToQueryGroup(7));

        arg.syncValue(const QueryGroup({'value': 'garbage'}));

        expect(arg.value, 42);
      },
    );

    test(
      'given a slider arg changed to another value, '
      'when its URL value is missing, '
      'then its value is the initial value',
      () {
        final arg = IntArg(42, name: 'int', style: slider);
        arg.syncValue(arg.valueToQueryGroup(7));

        arg.syncValue(QueryGroup.empty);

        expect(arg.value, 42);
      },
    );
  });

  group('$NullableIntArg', () {
    test(
      'given an input arg left at its initial value, '
      'when it is nullified, '
      'then its field shows the initial value',
      () {
        final arg = NullableIntArg(42, name: 'int');

        arg.syncValue(QueryGroup.nullified);

        expect(arg.field.valueFrom(QueryGroup.nullified), 42);
      },
    );

    test(
      'given a nullified input arg left at its initial value, '
      'when it is un-nullified, '
      'then its value is the initial value',
      () {
        final arg = NullableIntArg(42, name: 'int');
        arg.syncValue(QueryGroup.nullified);

        arg.syncValue(QueryGroup.nullified.unnullify());

        expect(arg.value, 42);
      },
    );

    test(
      'given a slider arg left at its initial value, '
      'when it is nullified, '
      'then its field shows the initial value',
      () {
        final arg = NullableIntArg(42, name: 'int', style: slider);

        arg.syncValue(QueryGroup.nullified);

        expect(arg.field.valueFrom(QueryGroup.nullified), 42);
      },
    );

    test(
      'given a nullified slider arg left at its initial value, '
      'when it is un-nullified, '
      'then its value is the initial value',
      () {
        final arg = NullableIntArg(42, name: 'int', style: slider);
        arg.syncValue(QueryGroup.nullified);

        arg.syncValue(QueryGroup.nullified.unnullify());

        expect(arg.value, 42);
      },
    );

    test(
      'given a nullified input arg changed to another value, '
      'when it is un-nullified, '
      'then its value is the changed value',
      () {
        final arg = NullableIntArg(42, name: 'int');
        final group = arg.valueToQueryGroup(7).nullify();
        arg.syncValue(group);

        arg.syncValue(group.unnullify());

        expect(arg.value, 7);
      },
    );

    test(
      'given a nullified slider arg changed to another value, '
      'when it is un-nullified, '
      'then its value is the changed value',
      () {
        final arg = NullableIntArg(42, name: 'int', style: slider);
        final group = arg.valueToQueryGroup(7).nullify();
        arg.syncValue(group);

        arg.syncValue(group.unnullify());

        expect(arg.value, 7);
      },
    );
  });
}
