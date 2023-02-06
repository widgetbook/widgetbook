import 'package:widgetbook_generator/code_generators/instances/addons/frame_addon/frames/frames.dart';
import 'package:widgetbook_generator/code_generators/instances/instance.dart';
import 'package:widgetbook_generator/code_generators/properties/property.dart';
import 'package:widgetbook_models/widgetbook_models.dart';

class DeviceFrameInstance extends Instance {
  DeviceFrameInstance({
    required List<Device> devices,
  }) : super(
          // TODO still not a huge fan of this name
          name: 'DefaultDeviceFrame',
          properties: [
            Property(
              key: 'setting',
              instance: DeviceFrameSettingInstance(
                devices: devices,
              ),
            ),
          ],
        );
}
