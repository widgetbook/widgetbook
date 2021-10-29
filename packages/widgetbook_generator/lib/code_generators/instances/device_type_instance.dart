import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_generator/code_generators/instances/primary_instance.dart';

class DeviceTypeInstance extends PrimaryInstance<DeviceType> {
  DeviceTypeInstance({
    required DeviceType deviceType,
  }) : super(
          value: deviceType,
        );

  @override
  String toCode() {
    return value.toString();
  }
}
