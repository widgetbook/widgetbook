import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  group('$StringArg', () {
    test(
      'given an arg changed to another value, '
      'when its URL value is missing, '
      'then its value is the initial value',
      () {
        final arg = StringArg('hello', name: 'string');
        arg.syncValue(arg.valueToQueryGroup('bye'));

        arg.syncValue(QueryGroup.empty);

        expect(arg.value, 'hello');
      },
    );
  });

  group('$NullableStringArg', () {
    test(
      'given an arg left at its initial value, '
      'when it is nullified, '
      'then its field shows the initial value',
      () {
        final arg = NullableStringArg('hello', name: 'string');

        arg.syncValue(QueryGroup.nullified);

        expect(arg.field.valueFrom(QueryGroup.nullified), 'hello');
      },
    );

    test(
      'given a nullified arg left at its initial value, '
      'when it is un-nullified, '
      'then its value is the initial value',
      () {
        final arg = NullableStringArg('hello', name: 'string');
        arg.syncValue(QueryGroup.nullified);

        arg.syncValue(QueryGroup.nullified.unnullify());

        expect(arg.value, 'hello');
      },
    );

    test(
      'given an arg changed to another value, '
      'when it is nullified, '
      'then its field shows the changed value',
      () {
        final arg = NullableStringArg('hello', name: 'string');
        final group = arg.valueToQueryGroup('bye').nullify();

        arg.syncValue(group);

        expect(arg.field.valueFrom(group), 'bye');
      },
    );

    test(
      'given a nullified arg changed to another value, '
      'when it is un-nullified, '
      'then its value is the changed value',
      () {
        final arg = NullableStringArg('hello', name: 'string');
        final group = arg.valueToQueryGroup('bye').nullify();
        arg.syncValue(group);

        arg.syncValue(group.unnullify());

        expect(arg.value, 'bye');
      },
    );
  });
}
