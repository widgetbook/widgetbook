import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_generator/json_formatter.dart';
import 'package:widgetbook_generator/models/widgetbook_story_data.dart';

class StoryResolver extends GeneratorForAnnotation<WidgetbookStory> {
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
    final widgetName = annotation.read('type').typeValue.getDisplayString(
          withNullability: false,
        );

    final data = WidgetbookStoryData.fromResolver(
      element,
      storyName,
      widgetName,
    );

    return [data].toJson();
  }
}
