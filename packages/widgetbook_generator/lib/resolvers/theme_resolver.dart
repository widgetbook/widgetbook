import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_generator/json_formatter.dart';
import 'package:widgetbook_generator/models/widgetbook_theme_data.dart';

class ThemeResolver extends GeneratorForAnnotation<WidgetbookTheme> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element.isPrivate) {
      throw InvalidGenerationSourceError(
        'Widgetbook annotations cannot be applied to private methods',
        element: element,
      );
    }

    final isDarkTheme = annotation.read('isDarkTheme').boolValue;

    final themeData = WidgetbookThemeData.fromResolver(
      element,
      isDarkTheme,
    );

    return [themeData].toJson();
  }
}
