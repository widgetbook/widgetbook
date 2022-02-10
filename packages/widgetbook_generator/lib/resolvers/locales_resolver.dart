import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_generator/extensions/element_extensions.dart';
import 'package:widgetbook_generator/models/widgetbook_locales_data.dart';
import 'package:widgetbook_generator/json_formatter.dart';

class LocalesResolver extends GeneratorForAnnotation<WidgetbookLocales> {
  @override
  String generateForAnnotatedElement(
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

    final data = WidgetbookLocalesData(
      name: element.name!,
      importStatement: element.importStatement,
      dependencies: [],
    );

    return [data].toJson();
  }
}
