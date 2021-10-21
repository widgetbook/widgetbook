import 'package:test/test.dart';
import 'package:widgetbook_models/src/devices/apple_devices.dart';
import 'package:widgetbook_models/src/devices/device.dart';
import 'package:widgetbook_models/src/devices/device_type.dart';
import 'package:widgetbook_models/src/devices/resolution.dart';

void testEquals({
  required Device Function(
    Resolution resolution,
  )
      createInstance,
}) {
  const width = 400.0;
  const height = width;
  const scalingFactor = 2.0;
  final resolution = Resolution.dimensions(
    nativeWidth: width,
    nativeHeight: height,
    scaleFactor: scalingFactor,
  );
  final instance1 = createInstance(
    resolution,
  );

  final instance2 = createInstance(
    resolution,
  );

  expect(
    instance1 == instance2,
    isTrue,
  );
}

void main() {
  group(
    '$Device',
    () {
      test(
        'and $Device.custom equal',
        () {
          final resolution = Resolution.dimensions(
            nativeWidth: 400,
            nativeHeight: 400,
            scaleFactor: 2,
          );
          final instance1 = Device.watch(
            name: 'Device',
            resolution: resolution,
          );

          final instance2 = Device.watch(
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
          const instance = Apple.iPhone11;

          expect(
            instance == instance,
            equals(true),
          );
        },
      );

      group(
        'returns true when',
        () {
          group('two instances with the same values are compared:', () {
            test(
              'Device',
              () {
                testEquals(
                  createInstance: (resolution) => Device(
                      name: 'Device',
                      resolution: resolution,
                      type: DeviceType.desktop),
                );
              },
            );

            test(
              'Device.watch',
              () {
                testEquals(
                  createInstance: (resolution) => Device.watch(
                    name: 'Device',
                    resolution: resolution,
                  ),
                );
              },
            );

            test(
              'Device.mobile',
              () {
                testEquals(
                  createInstance: (resolution) => Device.mobile(
                    name: 'Device',
                    resolution: resolution,
                  ),
                );
              },
            );

            test(
              'Device.tablet',
              () {
                testEquals(
                  createInstance: (resolution) => Device.tablet(
                    name: 'Device',
                    resolution: resolution,
                  ),
                );
              },
            );

            test(
              'Device.desktop',
              () {
                testEquals(
                  createInstance: (resolution) => Device.desktop(
                    name: 'Device',
                    resolution: resolution,
                  ),
                );
              },
            );

            test(
              'Device.special',
              () {
                testEquals(
                  createInstance: (resolution) => Device.special(
                    name: 'Device',
                    resolution: resolution,
                  ),
                );
              },
            );
          });

          test(
            'two instances with the same values are compared',
            () {
              final instance1 = Device.mobile(
                name: 'Device',
                resolution: Resolution.dimensions(
                  nativeWidth: 400,
                  nativeHeight: 400,
                  scaleFactor: 2,
                ),
              );

              final instance2 = Device.mobile(
                name: 'Device',
                resolution: Resolution.dimensions(
                  nativeWidth: 400,
                  nativeHeight: 400,
                  scaleFactor: 2,
                ),
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
              final instance1 = Device.desktop(
                name: 'Device',
                resolution: Resolution.dimensions(
                  nativeWidth: 400,
                  nativeHeight: 400,
                  scaleFactor: 2,
                ),
              );

              final instance2 = Device.desktop(
                name: 'Device',
                resolution: Resolution.dimensions(
                  nativeWidth: 400,
                  nativeHeight: 400,
                  scaleFactor: 2,
                ),
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
