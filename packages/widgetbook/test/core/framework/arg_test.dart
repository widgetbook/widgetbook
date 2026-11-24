import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  group('$Arg', () {
    test(
      'given a nullable arg changed to another value, '
      'when it is nullified, '
      'then its field shows the changed value',
      () {
        final arg = NullableStringArg('hello', name: 'label');
        final group = const QueryGroup({'value': 'bye'}).nullify();

        arg.syncValue(group);

        expect(arg.field.valueFrom(group), 'bye');
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
  });
}
