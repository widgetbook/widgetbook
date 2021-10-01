import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/providers/zoom_state.dart';

void main() {
  group(
    '$ZoomState',
    () {
      test(
        'returns true when instance is the same',
        () {
          var instance = ZoomState.normal();

          expect(
            instance == instance,
            equals(true),
          );
        },
      );

      group(
        'returns true when',
        () {
          test(
            'two instances with the same values are compared',
            () {
              var instance1 = ZoomState.normal();
              var instance2 = ZoomState.normal();

              expect(
                instance1 == instance2,
                equals(true),
              );
            },
          );

          test(
            'the hashCodes of two instances with the same values are compared',
            () {
              var instance1 = ZoomState.normal();
              var instance2 = ZoomState.normal();

              expect(
                instance1.hashCode == instance2.hashCode,
                equals(true),
              );
            },
          );
        },
      );
    },
  );
}
