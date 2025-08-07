import 'dart:io';

import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';

import 'collectors/collector_ast_visitor.dart';

/// An analyzer that uses [parseFile] to parse Dart files instead of
/// spawning a full analysis context. [parseFile] is a lightweight way to
/// parse a single file without the overhead of creating a full analysis context.
class ShallowAnalyzer {
  const ShallowAnalyzer(this.rootPath);

  final String rootPath;

  /// Collects data from Dart files in the specified [rootPath]
  /// using the provided [collector].
  Set<TData> collect<TData, TNode extends AstNode>(
    CollectorAstVisitor<TData, TNode> collector,
  ) {
    final files = _getDartFiles(rootPath);

    for (final file in files) {
      final result = parseFile(
        path: file.absolute.path,
        featureSet: FeatureSet.latestLanguageVersion(),
      );

      result.unit.visitChildren(collector);
    }

    return collector.data;
  }

  List<File> _getDartFiles(String directoryPath) {
    return Directory(directoryPath)
        .listSync(recursive: true)
        .whereType<File>()
        .where((file) => file.path.endsWith('.dart'))
        .toList();
  }
}
