import 'package:widgetbook_generator/writer/code_writer.dart';
import 'package:widgetbook_generator/writer/device_type_writer.dart';
import 'package:widgetbook_generator/writer/resolution_writer.dart';
import 'package:widgetbook_models/widgetbook_models.dart';

class DeviceWriter extends CodeWriter<Device> {
  DeviceWriter(
      {ResolutionWriter? resolutionWriter, DeviceTypeWriter? deviceTypeWriter})
      : resolutionWriter = resolutionWriter ?? ResolutionWriter(),
        deviceTypeWriter = deviceTypeWriter ?? DeviceTypeWriter();

  final ResolutionWriter resolutionWriter;
  final DeviceTypeWriter deviceTypeWriter;

  @override
  String write(Device type) {
    return '''
$Device(
  name: '${type.name}',
  resolution: ${resolutionWriter.write(type.resolution)},
  type: ${deviceTypeWriter.write(type.type)}
)
    ''';
  }
}
