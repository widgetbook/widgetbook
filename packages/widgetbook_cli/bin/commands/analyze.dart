import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/file_system/physical_file_system.dart';

import './command.dart';

class WidgetbookLocalesVisitor extends RecursiveAstVisitor<void> {
  @override
  void visitAnnotation(Annotation node) {
    node.visitChildren(this);
    print(node.name);
    if (node.name.name == 'WidgetbookLocales') {
      print('It is WidgetbookLocales');
    }
    return;
  }
}

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
        final result = collection
            .contextFor(
              filePath,
            )
            .currentSession
            .getParsedUnit(
              filePath,
            ) as ParsedUnitResult;

        result.unit.visitChildren(WidgetbookLocalesVisitor());
      }
    }

    return 0;
  }
}
