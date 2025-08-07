import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';

import 'collectors/collector_ast_visitor.dart';

/// An analyzer that uses [AnalysisContextCollection] to analyze Dart files
/// in a given directory.
/// The operations in this class can block the main isolate, so it is
/// recommended to run it in a separate isolate.
class DeepAnalyzer {
  const DeepAnalyzer(this.rootPath);

  final String rootPath;

  /// Collects data from Dart files in the specified [rootPath]
  /// using the provided [collector].
  Future<Set<TData>> collect<TData, TNode extends AstNode>(
    CollectorAstVisitor<TData, TNode> collector,
  ) async {
    final collection = AnalysisContextCollection(
      includedPaths: [rootPath],
    );

    final context = collection.contextFor(rootPath);
    final analyzedFilesPath = context.contextRoot.analyzedFiles();

    for (final filePath in analyzedFilesPath) {
      final session = context.currentSession;
      final result = await session.getResolvedUnit(filePath);

      if (result is! ResolvedUnitResult) continue;

      result.unit.visitChildren(collector);
    }

    collection.dispose();

    return collector.data;
  }
}
