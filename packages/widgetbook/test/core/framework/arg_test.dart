import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  group('$Arg', () {
    test(
      'given a nullified nullable arg, '
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
  });
}
