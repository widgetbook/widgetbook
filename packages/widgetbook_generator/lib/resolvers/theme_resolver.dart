import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_generator/extensions/element_extensions.dart';
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

    if (element.kind != ElementKind.FUNCTION ||
        !(element as FunctionElement).isStatic) {
      throw InvalidGenerationSourceError(
        'The $WidgetbookTheme annotation cannot be applied to static '
        'functions.',
        element: element,
      );
    }

    final isDefault = annotation.read('isDefault').boolValue;
    final name = annotation.read('name').stringValue;

    final themeData = WidgetbookThemeData(
      name: element.name,
      importStatement: element.importStatement,
      dependencies: element.dependencies,
      isDefault: isDefault,
      themeName: name,
    );

    return [themeData].toJson();
  }
}
