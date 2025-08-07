import 'dart:async';

import 'package:analyzer/dart/ast/ast.dart';
import 'package:collection/collection.dart';

import 'collectors/collector_ast_visitor.dart';

abstract class BaseAnalyzer {
  const BaseAnalyzer(this.rootPath);

  final String rootPath;

  /// Collect data from Dart files in the specified [rootPath].
  FutureOr<Set<TData>> collect<TData, TNode extends AstNode>(
    CollectorAstVisitor<TData, TNode> collector,
  );

  /// Filters the list of [files] to include only non-generated Dart files.
  Iterable<String> filterDartCodeFiles(Iterable<String> files) {
    return files
        .where((file) => file.endsWith('.dart'))
        .whereNot((file) => file.endsWith('.g.dart'))
        .whereNot((file) => file.endsWith('.freezed.dart'));
  }
}
