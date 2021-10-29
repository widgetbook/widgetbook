import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_generator/code_generators/instances/instance.dart';
import 'package:widgetbook_generator/code_generators/properties/property.dart';

class DeviceSizeInstance extends Instance {
  DeviceSizeInstance({
    required DeviceSize deviceSize,
  }) : super(
          name: 'DeviceSize',
          properties: [
            Property.double(key: 'height', value: deviceSize.height),
            Property.double(key: 'width', value: deviceSize.width),
          ],
        );
}
