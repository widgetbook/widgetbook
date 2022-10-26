import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/file_system/physical_file_system.dart';

import './command.dart';

class WidgetbookLocalesVisitor extends RecursiveAstVisitor<void> {
  @override
  void visitAnnotation(Annotation node) {
    node.visitChildren(this);

    print(node.name);
    if (node.name.name == 'WidgetbookLocales') {
      final locales = <String>[];
      // This is some super sketchy implementation
      final declarationNode = node.parent;
      final variableDeclarationNode =
          declarationNode.childEntities.toList()[1] as AstNode;
      final xxx = variableDeclarationNode.childEntities.toList()[1] as AstNode;
      // From here on the code is pretty much the same as in the LocalesResolver
      // from the widgetbook_generator package
      // see:
      // packages/widgetbook_generator/lib/resolvers/locales_resolver.dart
      final entities = xxx.childEntities.toList();
      if (entities[0] is Token &&
          entities[1] is Token &&
          entities[2] is ListLiteral) {
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

      print(locales);
    }

    return;
  }
}

class TextException implements Exception {}

class AnalyzeCommand extends WidgetbookCommand {
  AnalyzeCommand({
    super.logger,
  });

  @override
  final String description = 'Extract use-cases';

  @override
  final String name = 'analyze';

  @override
  Future<int> run() async {
    const path =
        '/Users/jenshorstmann/Files/Work/repos-review/widgetbook/widgetbook/examples/widgetbook_annotation_example';
    final collection = AnalysisContextCollection(
      includedPaths: [
        path,
      ],
      resourceProvider: PhysicalResourceProvider.INSTANCE,
    );

    final context = collection.contextFor(path);
    final analyzedFiles = context.contextRoot.analyzedFiles().toList();

    for (final filePath in analyzedFiles) {
      final file = context.currentSession.getFile(filePath);
      if (file is FileResult &&
          !file.isPart &&
          file.isLibrary &&
          filePath.endsWith('.dart')) {
        final someResolvedResult = await collection
            .contextFor(
              filePath,
            )
            .currentSession
            .getResolvedUnit(
              filePath,
            );
        final result = someResolvedResult as ResolvedUnitResult;

        result.unit.visitChildren(WidgetbookLocalesVisitor());
      }
    }

    return 0;
  }
}
