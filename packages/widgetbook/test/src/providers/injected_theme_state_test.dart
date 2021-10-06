import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/models/device.dart';
import 'package:widgetbook/src/providers/device_state.dart';

void main() {
  group(
    '$DeviceState',
    () {
      test(
        'returns true when instance is the same',
        () {
          final instance = DeviceState(
            availableDevices: [],
            currentDevice: Apple.iPhone11,
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
              final instance1 = DeviceState(
                availableDevices: [],
                currentDevice: Apple.iPhone11,
              );

              final instance2 = DeviceState(
                availableDevices: [],
                currentDevice: Apple.iPhone11,
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
              final list = <Device>[];
              final instance1 = DeviceState(
                availableDevices: list,
                currentDevice: Apple.iPhone11,
              );

              final instance2 = DeviceState(
                availableDevices: list,
                currentDevice: Apple.iPhone11,
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
