import 'package:widgetbook_generator/writer/code_writer.dart';
import 'package:widgetbook_generator/writer/device_size_writer.dart';
import 'package:widgetbook_models/widgetbook_models.dart';

class ResolutionWriter extends CodeWriter<Resolution> {
  ResolutionWriter({
    DeviceSizeWriter? deviceSizeWriter,
  }) : deviceSizeWriter = deviceSizeWriter ?? DeviceSizeWriter();

  final DeviceSizeWriter deviceSizeWriter;

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
