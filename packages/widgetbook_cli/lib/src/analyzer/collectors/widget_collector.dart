import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';

import 'collector_ast_visitor.dart';

/// Collects widget classes' names from a Flutter project.
class WidgetCollector extends CollectorAstVisitor<String, ClassDeclaration> {
  @override
  bool shouldCollect(ClassDeclaration node) {
    // Skip private classes
    if (node.name.toString().startsWith('_')) return false;

    // Skip classes that have the ignore comment
    final firstToken = node.firstTokenAfterCommentAndMetadata;
    final comment = firstToken.precedingComments?.lexeme;
    if (comment == '// widgetbook: ignore') return false;

    return node.declaredElement?.isWidget == true;
  }

  @override
  String mapNode(ClassDeclaration node) {
    return node.name.toString();
  }
}

extension on ClassElement {
  /// Whether the class is extending a "Widget" class.
  bool get isWidget {
    if (name == 'Widget') return true;

    final superElement = this.supertype?.element;
    if (superElement is! ClassElement) return false;

    return superElement.isWidget;
  }
}
