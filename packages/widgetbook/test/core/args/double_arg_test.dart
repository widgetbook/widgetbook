import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  const slider = SliderDoubleArgStyle(min: 0, max: 2, divisions: 4);

  group('$DoubleArg', () {
    test(
      'given an input arg changed to another value, '
      'when its URL value is missing, '
      'then its value is the initial value',
      () {
        final arg = DoubleArg(1.5, name: 'double');
        arg.syncValue(arg.valueToQueryGroup(0.5));

        arg.syncValue(QueryGroup.empty);

        expect(arg.value, 1.5);
      },
    );

    test(
      'given a slider arg changed to another value, '
      'when its URL value is missing, '
      'then its value is the initial value',
      () {
        final arg = DoubleArg(1.5, name: 'double', style: slider);
        arg.syncValue(arg.valueToQueryGroup(0.5));

        arg.syncValue(QueryGroup.empty);

        expect(arg.value, 1.5);
      },
    );
  });

  group('$NullableDoubleArg', () {
    test(
      'given an input arg left at its initial value, '
      'when it is nullified, '
      'then its field shows the initial value',
      () {
        final arg = NullableDoubleArg(1.5, name: 'double');

        arg.syncValue(QueryGroup.nullified);

        expect(arg.field.valueFrom(QueryGroup.nullified), 1.5);
      },
    );

    test(
      'given a nullified input arg left at its initial value, '
      'when it is un-nullified, '
      'then its value is the initial value',
      () {
        final arg = NullableDoubleArg(1.5, name: 'double');
        arg.syncValue(QueryGroup.nullified);

        arg.syncValue(QueryGroup.nullified.unnullify());

        expect(arg.value, 1.5);
      },
    );

    test(
      'given a slider arg left at its initial value, '
      'when it is nullified, '
      'then its field shows the initial value',
      () {
        final arg = NullableDoubleArg(1.5, name: 'double', style: slider);

        arg.syncValue(QueryGroup.nullified);

        expect(arg.field.valueFrom(QueryGroup.nullified), 1.5);
      },
    );

    test(
      'given a nullified slider arg left at its initial value, '
      'when it is un-nullified, '
      'then its value is the initial value',
      () {
        final arg = NullableDoubleArg(1.5, name: 'double', style: slider);
        arg.syncValue(QueryGroup.nullified);

        arg.syncValue(QueryGroup.nullified.unnullify());

        expect(arg.value, 1.5);
      },
    );

    test(
      'given a nullified input arg changed to another value, '
      'when it is un-nullified, '
      'then its value is the changed value',
      () {
        final arg = NullableDoubleArg(1.5, name: 'double');
        final group = arg.valueToQueryGroup(0.5).nullify();
        arg.syncValue(group);

        arg.syncValue(group.unnullify());

        expect(arg.value, 0.5);
      },
    );

    test(
      'given a nullified slider arg changed to another value, '
      'when it is un-nullified, '
      'then its value is the changed value',
      () {
        final arg = NullableDoubleArg(1.5, name: 'double', style: slider);
        final group = arg.valueToQueryGroup(0.5).nullify();
        arg.syncValue(group);

        arg.syncValue(group.unnullify());

        expect(arg.value, 0.5);
      },
    );
  });
}
