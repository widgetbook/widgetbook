import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_generator/json_formatter.dart';
import 'package:widgetbook_generator/models/widgetbook_device_data.dart';

class DeviceResolver extends GeneratorForAnnotation<WidgetbookApp> {
  @override
  dynamic generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element.isPrivate) {
      throw InvalidGenerationSourceError(
        'Widgetbook annotations cannot be applied to private elements',
        element: element,
      );
    }

    final deviceObjects = annotation.read('devices').listValue;
    final devices = <String>[];
    for (final deviceObject in deviceObjects) {
      final name = deviceObject.getField('name')!.toStringValue()!;
      devices.add(name);
    }

    final data = devices
        .map(
          (e) => WidgetbookDeviceData(
            name: e,
          ),
        )
        .toList();

    return data.toJson();
  }
}
