import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:path/path.dart' as p;

import 'collector_ast_visitor.dart';

/// A single public constructor of a widget class.
class ConstructorInfo {
  const ConstructorInfo({
    required this.name,
    required this.parameterTypes,
  });

  /// The named constructor, e.g. `'icon'` for `Button.icon`.
  /// `null` for the unnamed (default) constructor.
  final String? name;

  final List<String> parameterTypes;

  bool get isDefault => name == null;

  /// PascalCase form of [name], used to prefix generated story symbols.
  /// Empty for the default constructor.
  String get classPrefix {
    final n = name;
    if (n == null || n.isEmpty) return '';
    return '${n[0].toUpperCase()}${n.substring(1)}';
  }
}

class WidgetInfo {
  const WidgetInfo({
    required this.name,
    required this.importPath,
    required this.constructors,
  });

  final String name;
  final String importPath;

  /// All public constructors of the widget, including the default one (if
  /// present). The default constructor (if any) is placed first.
  final List<ConstructorInfo> constructors;

  String get filePath => importPath.split('/').sublist(1).join('/');
  String get dirname => p.dirname(filePath);
  String get filename => p.basenameWithoutExtension(filePath);

  /// The filename to use for the generated `.stories.dart` file. One file
  /// per widget, sharing the source file's basename.
  String get storiesFilename => filename;
}

/// Collects [WidgetInfo] about widget classes from a Flutter project.
class WidgetInfoCollector
    extends CollectorAstVisitor<WidgetInfo, ClassDeclaration> {
  @override
  bool shouldCollect(ClassDeclaration node) {
    // Skip private classes
    if (node.namePart.toString().startsWith('_')) return false;

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

    return node.declaredFragment?.element.isUiWidget == true;
  }

  @override
  WidgetInfo mapNode(ClassDeclaration node) {
    final element = node.declaredFragment?.element;
    final constructors = element?.constructors ?? const [];

    final infos = <ConstructorInfo>[];
    for (final constructor in constructors) {
      if (constructor.isFactory) continue;

      final name = constructor.name;
      final isDefault = name == null || name.isEmpty || name == 'new';
      if (!isDefault && name.startsWith('_')) continue;

      infos.add(
        ConstructorInfo(
          name: isDefault ? null : name,
          parameterTypes: constructor.formalParameters
              .map((param) => param.type.toString())
              .toList(),
        ),
      );
    }

    // Default constructor first, named constructors after in source order.
    infos.sort((a, b) {
      if (a.isDefault && !b.isDefault) return -1;
      if (!a.isDefault && b.isDefault) return 1;
      return 0;
    });

    return WidgetInfo(
      name: node.namePart.toString(),
      importPath: element?.library.uri.toString() ?? '',
      constructors: infos,
    );
  }
}

extension on ClassElement {
  /// Whether the class is extending a "Widget" class.
  /// `InheritedWidget` are ignored since they are not "UI" widgets.
  bool get isUiWidget {
    if (name == 'InheritedWidget') return false;
    if (name == 'Widget') return true;

    final superElement = this.supertype?.element;
    if (superElement is! ClassElement) return false;

    return superElement.isUiWidget;
  }
}
