import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';

import 'base_analyzer.dart';
import 'collectors/collector_ast_visitor.dart';

/// An analyzer that uses [AnalysisContextCollection] to analyze Dart files
/// in a given directory.
/// The operations in this class can block the main isolate, so it is
/// recommended to run it in a separate isolate.
class DeepAnalyzer extends BaseAnalyzer {
  const DeepAnalyzer(super.rootPath);

  /// Collects data from Dart files in the specified [rootPath]
  /// using the provided [collector].
  Future<Set<TData>> collect<TData, TNode extends AstNode>(
    CollectorAstVisitor<TData, TNode> collector,
  ) async {
    final collection = AnalysisContextCollection(
      // Only absolute normalized paths are supported
      includedPaths: [absoluteLibPath],
    );

    final context = collection.contextFor(absoluteLibPath);
    final session = context.currentSession;

    final allFiles = context.contextRoot.analyzedFiles();
    final dartFiles = filterDartCodeFiles(allFiles);

    for (final file in dartFiles) {
      final result = await session.getResolvedUnit(file);
      if (result is! ResolvedUnitResult) continue;
      result.unit.visitChildren(collector);
    }

    collection.dispose();

    return collector.data;
  }
}
