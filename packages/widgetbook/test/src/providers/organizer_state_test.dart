import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/providers/organizer_state.dart';

import '../../helper/model_helper.dart';

void main() {
  group(
    '$OrganizerState',
    () {
      test(
        'the hashCodes of two instances with the same values are compared',
        () {
          final instance1 = OrganizerState.unfiltered(
            categories: [],
          );

          final instance2 = OrganizerState.unfiltered(
            categories: [],
          );

          expectEqualHashCodes(instance1, instance2);
        },
      );
    },
  );
}
