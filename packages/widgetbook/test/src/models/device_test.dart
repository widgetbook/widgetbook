import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/models/device.dart';
import 'package:widgetbook/src/models/resolution.dart';

void main() {
  group(
    '$Device',
    () {
      test(
        'and $Device.custom equal',
        () {
          final resolution = Resolution.dimensions(
            width: 400,
            height: 400,
            scaleFactor: 2,
          );
          final instance1 = Device(
            name: 'Device',
            resolution: resolution,
            type: DeviceType.unknown,
          );

          final instance2 = Device.custom(
            resolution: resolution,
            name: 'Device',
          );

          expect(
            instance1 == instance2,
            equals(true),
          );
        },
      );

      test(
        'returns true when instance is the same',
        () {
          final instance = Apple.iPhone11;

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
              final instance1 = Device(
                name: 'Device',
                resolution: Resolution.dimensions(
                  width: 400,
                  height: 400,
                  scaleFactor: 2,
                ),
                type: DeviceType.unknown,
              );

              final instance2 = Device(
                name: 'Device',
                resolution: Resolution.dimensions(
                  width: 400,
                  height: 400,
                  scaleFactor: 2,
                ),
                type: DeviceType.unknown,
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
              final instance1 = Device(
                name: 'Device',
                resolution: Resolution.dimensions(
                  width: 400,
                  height: 400,
                  scaleFactor: 2,
                ),
                type: DeviceType.unknown,
              );

              final instance2 = Device(
                name: 'Device',
                resolution: Resolution.dimensions(
                  width: 400,
                  height: 400,
                  scaleFactor: 2,
                ),
                type: DeviceType.unknown,
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
