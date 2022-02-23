import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:widgetbook_generator/extensions/element_extensions.dart';
import 'package:widgetbook_generator/json_formatter.dart';
import 'package:widgetbook_generator/models/widgetbook_data.dart';

abstract class BuilderFunctionResolver<T> extends GeneratorForAnnotation<T> {
  const BuilderFunctionResolver({
    required this.createData,
  });

  final WidgetbookData Function(
    String name,
    String importStatement,
    List<String> dependencies,
  ) createData;

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element.isPrivate) {
      throw InvalidGenerationSourceError(
        'Widgetbook annotations cannot be applied to private getter or methods',
        element: element,
      );
    }

    final data = createData(
      element.name!,
      element.importStatement,
      element.dependencies,
    );

    return [data].toJson();
  }
}
