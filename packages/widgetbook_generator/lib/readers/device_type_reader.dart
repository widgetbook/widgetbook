import 'package:analyzer/dart/constant/value.dart';
import 'package:widgetbook_generator/readers/annotation_reader.dart';
import 'package:widgetbook_models/widgetbook_models.dart';

/// Parses [DartObject] into an object of type [DeviceType]
class DeviceTypeReader extends AnnotationReader<DeviceType> {
  @override
  DeviceType read(DartObject object) {
    final index = object.getField('index')!.toIntValue()!;
    return DeviceType.values[index];
  }
}
