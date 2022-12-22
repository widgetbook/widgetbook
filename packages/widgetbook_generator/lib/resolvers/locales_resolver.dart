import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_generator/extensions/element_extensions.dart';
import 'package:widgetbook_generator/json_formatter.dart';
import 'package:widgetbook_generator/models/widgetbook_locales_data.dart';

class LocalesResolver extends GeneratorForAnnotation<WidgetbookLocales> {
  @override
  Future<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    if (element.isPrivate) {
      throw InvalidGenerationSourceError(
        'Widgetbook annotations cannot be applied to private elements',
        element: element,
      );
    }

    final locales = <String>[];

    final node = await buildStep.resolver.astNodeFor(element);
    if (node != null) {
      final entities = node.childEntities.toList();
      if (entities[1] is Token && entities[2] is ListLiteral) {
        final listLiteral = entities[2] as ListLiteral;
        // TODO this is likely the most flaky code that has ever been written
        // check the following cases
        // - Locale('en')
        // - const Locale('en')
        // - Locale('en', 'US')
        // - const Locale('en', 'US')
        // - additional methods, e.g. Locale.fromString('...') and similar stuff
        // Maybe it's best to just use a regex
        final localeDefinitions = listLiteral.elements.toList();
        for (final localeDefinition in localeDefinitions) {
          // If expression starts WITHOUT const e.g. Local('en'), this will
          // be called
          if (localeDefinition is MethodInvocation) {
            final stringLiteral =
                localeDefinition.argumentList.arguments.first as StringLiteral;
            final value = stringLiteral.stringValue!;
            locales.add(value);
          }
          // If expression starts WITH const e.g. const Local('en'), this will
          // be called
          if (localeDefinition is InstanceCreationExpression) {
            final stringLiteral =
                localeDefinition.argumentList.arguments.first as StringLiteral;
            final value = stringLiteral.stringValue!;
            locales.add(value);
          }
        }
      }
    }

    final data = WidgetbookLocalesData(
      name: element.name!,
      importStatement: element.importStatement,
      dependencies: [],
      locales: locales,
    );

    return [data].toJson();
  }
}
