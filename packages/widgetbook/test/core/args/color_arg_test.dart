import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  const initialColor = Color(0xFF123456);

  group('$ColorArg', () {
    test(
      'given an arg changed to another value, '
      'when its URL value is missing, '
      'then its value is the initial value',
      () {
        final arg = ColorArg(initialColor, name: 'color');
        arg.syncValue(arg.valueToQueryGroup(const Color(0xFF000000)));

        arg.syncValue(QueryGroup.empty);

        expect(arg.value, initialColor);
      },
    );
  });

  group('$NullableColorArg', () {
    test(
      'given an arg left at its initial value, '
      'when it is nullified, '
      'then its field shows the initial value',
      () {
        final arg = NullableColorArg(initialColor, name: 'color');

        arg.syncValue(QueryGroup.nullified);

        expect(arg.field.valueFrom(QueryGroup.nullified), initialColor);
      },
    );

    test(
      'given a nullified arg left at its initial value, '
      'when it is un-nullified, '
      'then its value is the initial value',
      () {
        final arg = NullableColorArg(initialColor, name: 'color');
        arg.syncValue(QueryGroup.nullified);

        arg.syncValue(QueryGroup.nullified.unnullify());

        expect(arg.value, initialColor);
      },
    );
  });
}
