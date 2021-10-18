import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook_models/src/devices/device_size.dart';
import 'package:widgetbook_models/src/devices/resolution.dart';

void main() {
  group(
    '$Resolution',
    () {
      test('returns Size(200, 200) when logicalSize is called', () {
        final instance = Resolution.dimensions(
          nativeHeight: 400,
          nativeWidth: 400,
          scaleFactor: 2,
        );

        expect(
          instance.logicalSize,
          equals(
            const DeviceSize(
              width: 200,
              height: 200,
            ),
          ),
        );
      });

      test(
        'returns true when instance is the same',
        () {
          final instance = Resolution.dimensions(
            nativeHeight: 1,
            nativeWidth: 1,
            scaleFactor: 1,
          );

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
              final instance1 = Resolution.dimensions(
                nativeHeight: 1,
                nativeWidth: 1,
                scaleFactor: 1,
              );
              final instance2 = Resolution.dimensions(
                nativeHeight: 1,
                nativeWidth: 1,
                scaleFactor: 1,
              );

              expect(
                instance1 == instance2,
                equals(true),
              );
            },
          );

          test(
            'the hashCodes of two instances with the same values are compared',
            () {
              final instance1 = Resolution.dimensions(
                nativeHeight: 1,
                nativeWidth: 1,
                scaleFactor: 1,
              );
              final instance2 = Resolution.dimensions(
                nativeHeight: 1,
                nativeWidth: 1,
                scaleFactor: 1,
              );

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
