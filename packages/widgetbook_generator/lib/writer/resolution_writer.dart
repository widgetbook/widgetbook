import 'package:widgetbook_generator/writer/code_writer.dart';
import 'package:widgetbook_generator/writer/device_size_writer.dart';
import 'package:widgetbook_models/widgetbook_models.dart';

class ResolutionWriter extends CodeWriter<Resolution> {
  final DeviceSizeWriter deviceSizeWriter;

  ResolutionWriter({
    DeviceSizeWriter? deviceSizeWriter,
  }) : deviceSizeWriter = deviceSizeWriter ?? DeviceSizeWriter();

  @override
  String write(Resolution type) {
    return '''
$Resolution(
  nativeSize: ${deviceSizeWriter.write(type.nativeSize)},
  scaleFactor: ${type.scaleFactor},
)
    ''';
  }
}
