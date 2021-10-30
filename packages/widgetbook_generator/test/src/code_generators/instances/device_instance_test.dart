import 'package:test/test.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_generator/code_generators/instances/device_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/device_type_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/resolution_instance.dart';
import 'package:widgetbook_generator/code_generators/properties/property.dart';

import '../instance_helper.dart';

void main() {
  group(
    '$DeviceInstance',
    () {
      final phone = Apple.iPhone11;
      final instance = DeviceInstance(device: phone);

      testName('$Device', instance: instance);

      test(
        ".properties returns two properties 'nativeSize' and 'scaleFactor'",
        () {
          expect(
            instance.properties,
            equals(
              [
                Property.string(key: 'name', value: phone.name),
                Property(
                  key: 'resolution',
                  instance: ResolutionInstance(
                    resolution: phone.resolution,
                  ),
                ),
                Property(
                  key: 'type',
                  instance: DeviceTypeInstance(
                    deviceType: phone.type,
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
