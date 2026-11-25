import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  const initialDuration = Duration(seconds: 7);

  group('$DurationArg', () {
    test(
      'given an arg changed to another value, '
      'when its URL value is missing, '
      'then its value is the initial value',
      () {
        final arg = DurationArg(initialDuration, name: 'duration');
        arg.syncValue(arg.valueToQueryGroup(const Duration(seconds: 2)));

        arg.syncValue(QueryGroup.empty);

        expect(arg.value, initialDuration);
      },
    );
  });

  group('$NullableDurationArg', () {
    test(
      'given an arg left at its initial value, '
      'when it is nullified, '
      'then its field shows the initial value',
      () {
        final arg = NullableDurationArg(initialDuration, name: 'duration');

        arg.syncValue(QueryGroup.nullified);

        expect(arg.field.valueFrom(QueryGroup.nullified), initialDuration);
      },
    );

    test(
      'given a nullified arg left at its initial value, '
      'when it is un-nullified, '
      'then its value is the initial value',
      () {
        final arg = NullableDurationArg(initialDuration, name: 'duration');
        arg.syncValue(QueryGroup.nullified);

        arg.syncValue(QueryGroup.nullified.unnullify());

        expect(arg.value, initialDuration);
      },
    );

    test(
      'given a nullified arg changed to another value, '
      'when it is un-nullified, '
      'then its value is the changed value',
      () {
        final arg = NullableDurationArg(initialDuration, name: 'duration');
        final group = arg
            .valueToQueryGroup(const Duration(seconds: 2))
            .nullify();
        arg.syncValue(group);

        arg.syncValue(group.unnullify());

        expect(arg.value, const Duration(seconds: 2));
      },
    );

    test(
      'given an arg changed to another value, '
      'when it is nullified, '
      'then its field shows the changed value',
      () {
        final arg = NullableDurationArg(initialDuration, name: 'duration');
        final group = arg
            .valueToQueryGroup(const Duration(seconds: 2))
            .nullify();

        arg.syncValue(group);

        expect(arg.field.valueFrom(group), const Duration(seconds: 2));
      },
    );
  });
}
