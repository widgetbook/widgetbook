import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_generator/extensions/element_extensions.dart';
import 'package:widgetbook_generator/json_formatter.dart';
import 'package:widgetbook_generator/models/widgetbook_use_case_data.dart';

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

    final useCaseName = annotation.read('name').stringValue;
    final typeElement = annotation.read('type').typeValue.element!;
    final designLinkReader = annotation.read('designLink');
    String? designLink;
    if (!designLinkReader.isNull) {
      designLink = designLinkReader.stringValue;
    }

    final typeValue = annotation.read('type').typeValue;
    final componentName = typeValue.getDisplayString(
      withNullability: false,
    );

    final componentDefinitionPath = typeValue.element!.librarySource!.fullName;

    final data = WidgetbookUseCaseData(
      name: element.name!,
      useCaseName: useCaseName,
      componentName: componentName,
      importStatement: element.importStatement,
      componentImportStatement: typeElement.importStatement,
      dependencies: typeElement.dependencies,
      componentDefinitionPath: componentDefinitionPath,
      useCaseDefinitionPath: element.librarySource!.fullName,
      designLink: designLink,
    );

    return [data].toJson();
  }
}
