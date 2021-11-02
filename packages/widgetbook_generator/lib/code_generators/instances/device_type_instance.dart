import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_generator/code_generators/instances/primary_instance.dart';

/// Implements a DeviceTypeInstance
class DeviceTypeInstance extends PrimaryInstance<DeviceType> {
  /// Creates a new instance of [DeviceTypeInstance]
  const DeviceTypeInstance({
    required DeviceType deviceType,
  }) : super(
          value: deviceType,
        );

  @override
  String toCode() {
    return value.toString();
  }
}
