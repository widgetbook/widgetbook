import 'package:test/test.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_generator/code_generators/instances/device_size_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/function_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/instance.dart';
import 'package:widgetbook_generator/code_generators/instances/resolution_instance.dart';
import 'package:widgetbook_generator/code_generators/properties/property.dart';

import '../instance_helper.dart';

void main() {
  group(
    '$ResolutionInstance',
    () {
      const scaleFactor = 2.0;
      const deviceSize = DeviceSize(
        height: 200,
        width: 200,
      );

      final instance = ResolutionInstance(
        resolution: const Resolution(
          scaleFactor: scaleFactor,
          nativeSize: deviceSize,
        ),
      );

      testName('$Resolution', instance: instance);

      test(
        ".properties returns two properties 'nativeSize' and 'scaleFactor'",
        () {
          expect(
            instance.properties,
            equals(
              [
                Property(
                  key: 'nativeSize',
                  instance: DeviceSizeInstance(
                    deviceSize: deviceSize,
                  ),
                ),
                Property.double(key: 'scaleFactor', value: scaleFactor),
              ],
            ),
          );
        },
      );
    },
  );
}
