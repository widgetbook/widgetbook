import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_generator/code_generators/instances/instances.dart';
import 'package:widgetbook_generator/code_generators/properties/property.dart';

class FrameAddonInstance extends AddOnInstance {
  FrameAddonInstance({
    required List<Device> devices,
  }) : super(
          name: 'FrameAddon',
          properties: [
            Property(
              key: 'setting',
              instance: FrameSettingInstance(
                devices: devices,
              ),
            ),
          ],
        );
}
