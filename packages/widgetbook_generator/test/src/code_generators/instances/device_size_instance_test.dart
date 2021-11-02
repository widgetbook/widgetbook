import 'package:test/test.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_generator/code_generators/instances/device_size_instance.dart';
import 'package:widgetbook_generator/code_generators/properties/property.dart';

import '../instance_helper.dart';

void main() {
  group(
    '$DeviceSizeInstance',
    () {
      const deviceSize = DeviceSize(
        height: 200,
        width: 200,
      );

      final instance = DeviceSizeInstance(deviceSize: deviceSize);

      testName('$DeviceSize', instance: instance);

      test(
        ".properties returns two double properties 'width' and 'height'",
        () {
          expect(
            instance.properties,
            equals(
              [
                Property.double(key: 'height', value: deviceSize.height),
                Property.double(key: 'width', value: deviceSize.width),
              ],
            ),
          );
        },
      );
    },
  );
}
