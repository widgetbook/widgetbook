import 'dart:io';

import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';

import 'base_analyzer.dart';
import 'collectors/collector_ast_visitor.dart';

/// An analyzer that uses [parseFile] to parse Dart files instead of
/// spawning a full analysis context. [parseFile] is a lightweight way to
/// parse a single file without the overhead of creating a full analysis context.
class ShallowAnalyzer extends BaseAnalyzer {
  const ShallowAnalyzer(super.rootPath);

  /// Similar to [ContextRoot.analyzedFiles].
  Iterable<String> analyzedFiles() {
    return Directory(rootPath)
        .listSync(recursive: true)
        .whereType<File>()
        .map((file) => file.absolute.path);
  }

  /// Collects data from Dart files in the specified [rootPath]
  /// using the provided [collector].
  Set<TData> collect<TData, TNode extends AstNode>(
    CollectorAstVisitor<TData, TNode> collector,
  ) {
    final allFiles = analyzedFiles();
    final dartFiles = filterDartCodeFiles(allFiles);

    for (final file in dartFiles) {
      final result = parseFile(
        path: file,
        featureSet: FeatureSet.latestLanguageVersion(),
      );

      result.unit.visitChildren(collector);
    }

    return collector.data;
  }
}
