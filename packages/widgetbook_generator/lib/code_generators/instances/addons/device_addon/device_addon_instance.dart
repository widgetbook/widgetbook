import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_generator/code_generators/instances/device_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/instances.dart';
import 'package:widgetbook_generator/code_generators/instances/list_instance.dart';
import 'package:widgetbook_generator/code_generators/properties/property.dart';

class DeviceAddonInstance extends AddOnInstance {
  DeviceAddonInstance({
    required List<Device> devices,
  }) : super(
          name: 'DeviceAddon',
          properties: [
            Property(
              key: 'devices',
              instance: ListInstance(
                instances: devices
                    .map(
                      (device) => DeviceInstance(
                        device: device,
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        );
}
