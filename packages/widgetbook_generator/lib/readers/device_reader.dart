import 'package:analyzer/dart/constant/value.dart';
import 'package:widgetbook_generator/readers/annotation_reader.dart';
import 'package:widgetbook_generator/readers/device_type_reader.dart';
import 'package:widgetbook_generator/readers/resolution_reader.dart';
import 'package:widgetbook_models/widgetbook_models.dart';

/// Parses [DartObject] into an object of type [Device]
class DeviceReader extends AnnotationReader<Device> {
  /// Creates a new object of [DeviceReader]
  ///
  /// [deviceTypeReader] defines a reader capable of parsing an [DartObject]
  /// into [DeviceType]
  /// [resolutioReader] defines a reader capable of parsing an [DartObject]
  /// into [Resolution]
  DeviceReader({
    DeviceTypeReader? deviceTypeReader,
    ResolutioReader? resolutioReader,
  })  : deviceTypeReader = deviceTypeReader ?? DeviceTypeReader(),
        resolutioReader = resolutioReader ?? ResolutioReader();

  /// A reader capable of parsing an [DartObject] into [DeviceType]
  final DeviceTypeReader deviceTypeReader;

  /// A reader capable of parsing an [DartObject] into [Resolution]
  final ResolutioReader resolutioReader;

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
