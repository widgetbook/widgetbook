import 'package:widgetbook_generator/writer/code_writer.dart';
import 'package:widgetbook_models/widgetbook_models.dart';

class DeviceSizeWriter extends CodeWriter<DeviceSize> {
  @override
  String write(DeviceSize type) {
    return '''
$DeviceSize(
  width: ${type.width},
  height: ${type.height},
)
    ''';
  }
}
