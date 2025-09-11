import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

/// An [AstVisitor] that collects data from AST nodes.
abstract class CollectorAstVisitor<TData, TNode extends AstNode>
    extends GeneralizingAstVisitor<void> {
  final Set<TData> data = {};

  /// Whether the visitor should collect data from the given [node].
  bool shouldCollect(TNode node);

  /// Maps the [node] to a data item of type [TData].
  TData mapNode(TNode node);

  @override
  void visitNode(AstNode node) {
    if (node is TNode) _collect(node);

    super.visitNode(node);
  }

  void _collect(TNode node) {
    if (!shouldCollect(node)) return;

    final mappedNode = mapNode(node);

    data.add(mappedNode);
  }
}
