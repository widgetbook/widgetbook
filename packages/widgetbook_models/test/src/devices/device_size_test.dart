import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook_models/widgetbook_models.dart';

void main() {
  group(
    '$DeviceSize',
    () {
      const original = DeviceSize(
        width: 100,
        height: 100,
      );

      test(
        'returns multiplied value when *operator is called',
        () {
          expect(
            original * 2,
            equals(
              const DeviceSize(
                width: 200,
                height: 200,
              ),
            ),
          );
        },
      );

      test(
        'returns divided value when *operator is called',
        () {
          expect(
            original / 2,
            equals(
              const DeviceSize(
                width: 50,
                height: 50,
              ),
            ),
          );
        },
      );
    },
  );
}
