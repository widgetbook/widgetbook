import 'package:analyzer/dart/constant/value.dart';
import 'package:widgetbook_generator/readers/annotation_reader.dart';
import 'package:widgetbook_generator/readers/device_size_reader.dart';
import 'package:widgetbook_models/widgetbook_models.dart';

/// Parses [DartObject] into an object of type [Resolution]
class ResolutioReader extends AnnotationReader<Resolution> {
  /// Creates a new object of [ResolutioReader]
  ///
  /// [deviceSizeReader] defines a reader capable of parsing an [DartObject]
  /// into [DeviceSize]
  ResolutioReader({DeviceSizeReader? deviceSizeReader})
      : deviceSizeReader = deviceSizeReader ?? DeviceSizeReader();

  /// A reader capable of parsing an [DartObject] into [DeviceSize]
  final DeviceSizeReader deviceSizeReader;

  @override
  Resolution read(DartObject object) {
    final deviceSize = deviceSizeReader.read(
      object.getField('nativeSize')!,
    );

    final scaleFactor = object.getField('scaleFactor')!.toDoubleValue()!;
    return Resolution(
      scaleFactor: scaleFactor,
      nativeSize: deviceSize,
    );
  }
}
