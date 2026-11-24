import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  const values = ['a', 'b'];
  const segmented = SegmentedSingleArgStyle();

  group('$SingleArg', () {
    test(
      'given a dropdown arg changed to another value, '
      'when its URL value is missing, '
      'then its value is the initial value',
      () {
        final arg = SingleArg('b', name: 'single', values: values);
        arg.syncValue(arg.valueToQueryGroup('a'));

        arg.syncValue(QueryGroup.empty);

        expect(arg.value, 'b');
      },
    );

    test(
      'given a segmented arg changed to another value, '
      'when its URL value is missing, '
      'then its value is the initial value',
      () {
        final arg = SingleArg(
          'b',
          name: 'single',
          values: values,
          style: segmented,
        );
        arg.syncValue(arg.valueToQueryGroup('a'));

        arg.syncValue(QueryGroup.empty);

        expect(arg.value, 'b');
      },
    );
  });

  group('$NullableSingleArg', () {
    test(
      'given a dropdown arg left at its initial value, '
      'when it is nullified, '
      'then its field shows the initial value',
      () {
        final arg = NullableSingleArg('b', name: 'single', values: values);

        arg.syncValue(QueryGroup.nullified);

        expect(arg.field.valueFrom(QueryGroup.nullified), 'b');
      },
    );

    test(
      'given a nullified dropdown arg left at its initial value, '
      'when it is un-nullified, '
      'then its value is the initial value',
      () {
        final arg = NullableSingleArg('b', name: 'single', values: values);
        arg.syncValue(QueryGroup.nullified);

        arg.syncValue(QueryGroup.nullified.unnullify());

        expect(arg.value, 'b');
      },
    );

    test(
      'given a segmented arg left at its initial value, '
      'when it is nullified, '
      'then its field shows the initial value',
      () {
        final arg = NullableSingleArg(
          'b',
          name: 'single',
          values: values,
          style: segmented,
        );

        arg.syncValue(QueryGroup.nullified);

        expect(arg.field.valueFrom(QueryGroup.nullified), 'b');
      },
    );

    test(
      'given a nullified segmented arg left at its initial value, '
      'when it is un-nullified, '
      'then its value is the initial value',
      () {
        final arg = NullableSingleArg(
          'b',
          name: 'single',
          values: values,
          style: segmented,
        );
        arg.syncValue(QueryGroup.nullified);

        arg.syncValue(QueryGroup.nullified.unnullify());

        expect(arg.value, 'b');
      },
    );

    test(
      'given a nullified dropdown arg changed to another value, '
      'when it is un-nullified, '
      'then its value is the changed value',
      () {
        final arg = NullableSingleArg('b', name: 'single', values: values);
        final group = arg.valueToQueryGroup('a').nullify();
        arg.syncValue(group);

        arg.syncValue(group.unnullify());

        expect(arg.value, 'a');
      },
    );

    test(
      'given a nullified segmented arg changed to another value, '
      'when it is un-nullified, '
      'then its value is the changed value',
      () {
        final arg = NullableSingleArg(
          'b',
          name: 'single',
          values: values,
          style: segmented,
        );
        final group = arg.valueToQueryGroup('a').nullify();
        arg.syncValue(group);

        arg.syncValue(group.unnullify());

        expect(arg.value, 'a');
      },
    );
  });
}
