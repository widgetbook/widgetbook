import 'package:test/test.dart';
import 'package:widgetbook_generator/code_generators/instances/addons/frame_addon/frames/widgetbook_frame/widgetbook_frame_setting_instance.dart';
import 'package:widgetbook_models/widgetbook_models.dart';

void main() {
  group('$WidgetbookFrameSettingInstance', () {
    test(
      '.name returns "DeviceSetting"',
      () {
        expect(
          WidgetbookFrameSettingInstance(
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
