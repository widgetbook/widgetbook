import 'package:analyzer/dart/ast/ast.dart';

import 'collector_ast_visitor.dart';

/// Collects components' names from Widgetbook project by looking for the
/// generic type parameter `T` of the `Meta<T>` class.
class ComponentCollector
    extends CollectorAstVisitor<String, VariableDeclaration> {
  @override
  bool shouldCollect(VariableDeclaration node) {
    final name = node.name.toString();
    if (name != 'meta') return false;

    final initializer = node.initializer;
    if (initializer == null) return false;

    final entities = initializer.childEntities;
    final constructorName = switch (entities) {
      // When constructor is called without keywords
      // Example: const meta = Meta<T>();
      // Entities: [SimpleIdentifier, TypeArgumentList, ...] => [Meta, <T>, ...]
      [SimpleIdentifier(:final name), ...] => name,

      // When constructor is called with `new` or `const`
      // Example: final meta = new Meta<T>();
      // Entities: [KeywordToken, ConstructorName, ...] => [new, Meta<T>, ...]
      [_, ConstructorName(:final type), ...] => type.name.toString(),

      _ => null,
    };

    return constructorName == 'Meta' || constructorName == 'MetaWithArgs';
  }

  @override
  String mapNode(VariableDeclaration node) {
    final initializer = node.initializer!;
    final entities = initializer.childEntities;

    final typeArguments = switch (entities) {
      [_, TypeArgumentList entity, ...] => entity,
      [_, ConstructorName(:final type), ...] => type.typeArguments!,
      _ => throw Exception('No TypeArgumentList found in ${entities}'),
    };

    final widgetType = typeArguments.arguments.first;

    return widgetType.toString();
  }
}
