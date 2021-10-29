import 'package:meta/meta.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_generator/code_generators/instances/device_type_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/instance.dart';
import 'package:widgetbook_generator/code_generators/instances/resolution_instance.dart';
import 'package:widgetbook_generator/code_generators/properties/property.dart';

@immutable
class DeviceInstance extends Instance {
  DeviceInstance({
    required Device device,
  }) : super(
          name: 'Device',
          properties: [
            Property.string(
              key: 'name',
              value: device.name,
            ),
            Property(
              key: 'resolution',
              instance: ResolutionInstance(
                resolution: device.resolution,
              ),
            ),
            Property(
              key: 'type',
              instance: DeviceTypeInstance(
                deviceType: device.type,
              ),
            ),
          ],
        );
}
