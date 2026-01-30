import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:path/path.dart' as p;

import 'collector_ast_visitor.dart';

class WidgetInfo {
  const WidgetInfo({
    required this.name,
    required this.importPath,
    required this.parameterTypes,
  });

  final String name;
  final String importPath;
  final List<String> parameterTypes;

  String get filePath => importPath.split('/').sublist(1).join('/');
  String get dirname => p.dirname(filePath);
  String get filename => p.basenameWithoutExtension(filePath);
}

/// Collects [WidgetInfo] about widget classes from a Flutter project.
class WidgetInfoCollector
    extends CollectorAstVisitor<WidgetInfo, ClassDeclaration> {
  @override
  bool shouldCollect(ClassDeclaration node) {
    // Skip private classes
    if (node.name.toString().startsWith('_')) return false;

    // Skip abstract classes
    if (node.abstractKeyword != null) return false;

    // Skip some annotated classes
    const skippedAnnotations = {'internal', 'deprecated', 'visibleForTesting'};
    final metadata = node.metadata;
    for (final annotation in metadata) {
      final name = annotation.name.name;
      if (skippedAnnotations.contains(name)) {
        return false;
      }
    }

    // Skip classes that have the ignore comment
    final firstToken = node.firstTokenAfterCommentAndMetadata;
    final comment = firstToken.precedingComments?.lexeme;
    if (comment == '// widgetbook: ignore') return false;

    return node.declaredFragment?.element.isWidget == true;
  }

  @override
  WidgetInfo mapNode(ClassDeclaration node) {
    final element = node.declaredFragment?.element;
    final constructors = element?.constructors ?? [];
    final defaultConstructor = constructors
        .cast<ConstructorElement?>()
        .firstWhere(
          (c) => c?.name == null || c!.name!.isEmpty,
          orElse: () => constructors.isNotEmpty ? constructors.first : null,
        );

    final parameterTypes =
        defaultConstructor?.formalParameters
            .map((param) => param.type.toString())
            .toList() ??
        <String>[];

    return WidgetInfo(
      name: node.name.toString(),
      importPath: element?.library.uri.toString() ?? '',
      parameterTypes: parameterTypes,
    );
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
