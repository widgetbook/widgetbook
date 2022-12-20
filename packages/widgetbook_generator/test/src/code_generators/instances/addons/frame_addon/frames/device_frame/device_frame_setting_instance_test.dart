import 'package:test/test.dart';
import 'package:widgetbook_generator/code_generators/instances/addons/frame_addon/frames/device_frame/device_frame_setting_instance.dart';
import 'package:widgetbook_models/widgetbook_models.dart';

void main() {
  group('$DeviceFrameSettingInstance', () {
    test(
      '.name returns "DeviceSetting"',
      () {
        expect(
          DeviceFrameSettingInstance(
            devices: const [
              Apple.iPhone11,
            ],
          ).name,
          equals('DeviceSetting'),
        );
      },
    );
  });
}
