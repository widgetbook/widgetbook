import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_generator/code_generators/instances/addons/frame_addon/frames/frames.dart';
import 'package:widgetbook_generator/code_generators/instances/instance.dart';
import 'package:widgetbook_generator/code_generators/instances/list_instance.dart';
import 'package:widgetbook_generator/code_generators/properties/property.dart';

class FrameSettingInstance extends Instance {
  FrameSettingInstance({
    required List<Device> devices,
  }) : super(
          name: 'FrameSetting',
          properties: [
            Property(
              key: 'frames',
              instance: ListInstance(
                instances: [
                  const NoFrameInstance(),
                  DeviceFrameInstance(devices: devices),
                  WidgetbookFrameInstance(devices: devices),
                ],
              ),
            ),
            const Property(
              key: 'activeFrame',
              instance: NoFrameInstance(),
            ),
          ],
        );
}
