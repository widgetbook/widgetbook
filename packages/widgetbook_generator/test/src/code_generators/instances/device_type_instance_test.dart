import 'package:test/test.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_generator/code_generators/instances/device_type_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/primary_instance.dart';

void main() {
  group(
    '$DeviceTypeInstance',
    () {
      const value = DeviceType.mobile;

      final instance = DeviceTypeInstance(deviceType: value);

      test('is of type $PrimaryInstance', () {
        expect(instance, isA<PrimaryInstance<DeviceType>>());
      });

      test(
        ".toCode returns 'DeviceType.mobile'",
        () {
          expect(
            instance.toCode(),
            equals('DeviceType.mobile'),
          );
        },
      );
    },
  );
}
