import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_generator/json_formatter.dart';
import 'package:widgetbook_generator/models/widgetbook_story_data.dart';

class UseCaseResolver extends GeneratorForAnnotation<WidgetbookUseCase> {
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

    final storyName = annotation.read('name').stringValue;
    final typeElement = annotation.read('type').typeValue.element!;

    final typeValue = annotation.read('type').typeValue;
    final widgetName = typeValue.getDisplayString(
      withNullability: false,
    );

    final widgetFilePath = typeValue.element!.librarySource!.fullName;

    final data = WidgetbookStoryData.fromResolver(
      element,
      typeElement,
      storyName,
      widgetName,
      widgetFilePath,
    );

    return [data].toJson();
  }
}
