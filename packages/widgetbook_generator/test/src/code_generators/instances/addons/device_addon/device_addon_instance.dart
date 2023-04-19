import 'package:test/test.dart';
import 'package:widgetbook_generator/code_generators/instances/instances.dart';
import 'package:widgetbook_models/widgetbook_models.dart';

void main() {
  group(
    '$DeviceAddonInstance',
    () {
      test('.name is "DeviceAddon"', () {
        final sut = DeviceAddonInstance(
          devices: const [
            Apple.iPhone11,
          ],
        );
        expect(sut.name, equals('DeviceAddon'));
      });
    },
  );
}
