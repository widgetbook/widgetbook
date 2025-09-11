import 'package:analyzer/dart/ast/ast.dart';

import 'collector_ast_visitor.dart';

/// Collects components' names from Widgetbook project by looking for the
/// `type` argument in the `@UseCase` annotation.
class ComponentCollector extends CollectorAstVisitor<String, Annotation> {
  @override
  bool shouldCollect(Annotation node) {
    // Use "contains" because it can be `widgetbook.UseCase`, `w.UseCase`, etc.
    return node.name.name.contains('UseCase');
  }

  @override
  String mapNode(Annotation node) {
    final typeArg = node.arguments!.arguments
        .whereType<NamedExpression>()
        .firstWhere((arg) => arg.name.label.name == 'type');

    return typeArg.expression.toString();
  }
}
