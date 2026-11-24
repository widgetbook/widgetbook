import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  group('$BoolArg', () {
    test(
      'given an arg changed to another value, '
      'when its URL value is missing, '
      'then its value is the initial value',
      () {
        final arg = BoolArg(true, name: 'bool');
        arg.syncValue(arg.valueToQueryGroup(false));

        arg.syncValue(QueryGroup.empty);

        expect(arg.value, true);
      },
    );
  });

  group('$NullableBoolArg', () {
    test(
      'given an arg left at its initial value, '
      'when it is nullified, '
      'then its field shows the initial value',
      () {
        final arg = NullableBoolArg(true, name: 'bool');

        arg.syncValue(QueryGroup.nullified);

        expect(arg.field.valueFrom(QueryGroup.nullified), true);
      },
    );

    test(
      'given a nullified arg left at its initial value, '
      'when it is un-nullified, '
      'then its value is the initial value',
      () {
        final arg = NullableBoolArg(true, name: 'bool');
        arg.syncValue(QueryGroup.nullified);

        arg.syncValue(QueryGroup.nullified.unnullify());

        expect(arg.value, true);
      },
    );

    test(
      'given a nullified arg changed to another value, '
      'when it is un-nullified, '
      'then its value is the changed value',
      () {
        final arg = NullableBoolArg(true, name: 'bool');
        final group = arg.valueToQueryGroup(false).nullify();
        arg.syncValue(group);

        arg.syncValue(group.unnullify());

        expect(arg.value, false);
      },
    );
  });
}
