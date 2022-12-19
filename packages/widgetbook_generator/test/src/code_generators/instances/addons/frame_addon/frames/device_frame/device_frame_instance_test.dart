import 'package:test/test.dart';
import 'package:widgetbook_generator/code_generators/instances/addons/frame_addon/frames/frames.dart';
import 'package:widgetbook_models/widgetbook_models.dart';

void main() {
  group(
    '$DeviceFrameInstance',
    () {
      test('.name is "DefaultDeviceFrame"', () {
        final sut = DeviceFrameInstance(
          devices: const [
            Apple.iPhone11,
          ],
        );
        expect(sut.name, equals('DefaultDeviceFrame'));
      });
    },
  );
}
