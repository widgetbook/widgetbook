import 'package:widgetbook_generator/writer/code_writer.dart';
import 'package:widgetbook_models/widgetbook_models.dart';

class DeviceTypeWriter extends CodeWriter<DeviceType> {
  @override
  String write(DeviceType type) {
    return type.toString();
  }
}
