import 'package:widgetbook_generator/code_generators/instances/device_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/instance.dart';
import 'package:widgetbook_generator/code_generators/instances/list_instance.dart';
import 'package:widgetbook_generator/code_generators/properties/property.dart';
import 'package:widgetbook_models/widgetbook_models.dart';

class DeviceFrameSettingInstance extends Instance {
  DeviceFrameSettingInstance({
    required List<Device> devices,
  }) : super(
          name: 'DeviceSetting',
          properties: [
            Property(
              key: 'devices',
              instance: ListInstance(
                instances: devices
                    .map(
                      (e) => DeviceInstance(device: e),
                    )
                    .toList(),
              ),
            ),
            Property(
              key: 'activeDevice',
              instance: DeviceInstance(device: devices.first),
            ),
          ],
        );
}
