import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/providers/organizer_state.dart';

void main() {
  group(
    '$OrganizerState',
    () {
      // TODO this can be extracted into a function for less redundant code
      test(
        'the hashCodes of two instances with the same values are compared',
        () {
          final instance1 = OrganizerState.unfiltered(
            categories: [],
          );

          final instance2 = OrganizerState.unfiltered(
            categories: [],
          );

          expect(
            instance1.hashCode == instance2.hashCode,
            equals(true),
          );
        },
      );
    },
  );
}
