import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/providers/device_state.dart';
import 'package:widgetbook/src/models/device.dart';

void main() {
  group(
    '$DeviceState',
    () {
      test(
        'returns true when instance is the same',
        () {
          var instance = DeviceState(
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
              var instance1 = DeviceState(
                availableDevices: [],
                currentDevice: Apple.iPhone11,
              );

              var instance2 = DeviceState(
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
              List<Device> list = [];
              var instance1 = DeviceState(
                availableDevices: list,
                currentDevice: Apple.iPhone11,
              );

              var instance2 = DeviceState(
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
