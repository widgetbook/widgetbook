import 'package:analyzer/dart/constant/value.dart';
import 'package:widgetbook_generator/readers/annotation_reader.dart';
import 'package:widgetbook_generator/readers/device_size_reader.dart';
import 'package:widgetbook_models/widgetbook_models.dart';

class ResolutioReader extends AnnotationReader<Resolution> {
  final DeviceSizeReader deviceSizeReader;

  ResolutioReader({DeviceSizeReader? deviceSizeReader})
      : deviceSizeReader = deviceSizeReader ?? DeviceSizeReader();

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
