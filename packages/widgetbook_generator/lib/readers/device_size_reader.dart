import 'package:analyzer/dart/constant/value.dart';
import 'package:widgetbook_generator/readers/annotation_reader.dart';
import 'package:widgetbook_models/widgetbook_models.dart';

/// Parses [DartObject] into an object of type [DeviceSize]
class DeviceSizeReader extends AnnotationReader<DeviceSize> {
  @override
  DeviceSize read(DartObject object) {
    final height = object.getField('height')!.toDoubleValue()!;
    final width = object.getField('width')!.toDoubleValue()!;
    return DeviceSize(width: width, height: height);
  }
}
