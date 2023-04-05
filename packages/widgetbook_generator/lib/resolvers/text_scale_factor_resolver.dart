import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_generator/json_formatter.dart';
import 'package:widgetbook_generator/models/widgetbook_text_scale_factor_data.dart';

class TextScaleFactorResolver extends GeneratorForAnnotation<WidgetbookApp> {
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

    final deviceObjects = annotation.read('textScaleFactors').listValue;
    final textScaleFactors = <double>[];
    for (final deviceObject in deviceObjects) {
      final value = deviceObject.toDoubleValue()!;
      textScaleFactors.add(value);
    }

    final data = textScaleFactors
        .map(
          (e) => WidgetbookTextScaleFactorData(
            value: e,
          ),
        )
        .toList();

    return data.toJson();
  }
}
