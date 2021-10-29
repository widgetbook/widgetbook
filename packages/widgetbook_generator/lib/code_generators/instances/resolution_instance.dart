import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_generator/code_generators/instances/device_size_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/instance.dart';
import 'package:widgetbook_generator/code_generators/properties/property.dart';

class ResolutionInstance extends Instance {
  ResolutionInstance({
    required Resolution resolution,
  }) : super(
          name: 'Resolution',
          properties: [
            Property(
              key: 'nativeSize',
              instance: DeviceSizeInstance(
                deviceSize: resolution.nativeSize,
              ),
            ),
            Property.double(
              key: 'scaleFactor',
              value: resolution.scaleFactor,
            )
          ],
        );
}
