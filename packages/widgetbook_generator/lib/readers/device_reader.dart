import 'package:analyzer/dart/constant/value.dart';
import 'package:widgetbook_generator/readers/annotation_reader.dart';
import 'package:widgetbook_generator/readers/device_type_reader.dart';
import 'package:widgetbook_generator/readers/resolution_reader.dart';
import 'package:widgetbook_models/widgetbook_models.dart';

class DeviceReader extends AnnotationReader<Device> {
  final DeviceTypeReader deviceTypeReader;
  final ResolutioReader resolutioReader;

  DeviceReader({
    DeviceTypeReader? deviceTypeReader,
    ResolutioReader? resolutioReader,
  })  : deviceTypeReader = deviceTypeReader ?? DeviceTypeReader(),
        resolutioReader = resolutioReader ?? ResolutioReader();

  @override
  Device read(DartObject object) {
    final name = object.getField('name')!.toStringValue()!;

    final type = deviceTypeReader.read(
      object.getField('type')!,
    );

    final resolution = resolutioReader.read(
      object.getField('resolution')!,
    );

    return Device(
      name: name,
      resolution: resolution,
      type: type,
    );
  }
}
