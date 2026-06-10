import 'package:analyzer/dart/ast/ast.dart';

import 'collector_ast_visitor.dart';

/// Collects components' names from Widgetbook project by looking at the
/// widget of the constructor tear-offs of `Meta` variables,
/// e.g. `Meta(MyWidget.new)`. The names of the variables do not matter.
///
/// Since the visitor collects into a `Set`, a file declaring multiple `Meta`
/// variants of the same widget still yields a single component name.
class ComponentCollector
    extends CollectorAstVisitor<String, VariableDeclaration> {
  @override
  bool shouldCollect(VariableDeclaration node) {
    final initializer = node.initializer;
    if (initializer == null) return false;

    return getConstructorName(initializer) == 'Meta';
  }

  @override
  String mapNode(VariableDeclaration node) {
    final initializer = node.initializer!;

    // The widget comes from the constructor tear-off passed as the first
    // positional argument, e.g. `Meta(MyWidget.new)`. Named arguments
    // (e.g. `argsType`) are skipped.
    final arguments = switch (initializer) {
      MethodInvocation(:final argumentList) => argumentList,
      InstanceCreationExpression(:final argumentList) => argumentList,
      _ => throw Exception('No ArgumentList found in ${initializer}'),
    };

    final tearOff = arguments.arguments
        .where((argument) => argument is! NamedArgument)
        .firstOrNull;

    return switch (tearOff) {
      // MyWidget.new
      ConstructorReference(:final constructorName) =>
        constructorName.type.name.toString(),
      // MyWidget.named
      PrefixedIdentifier(:final prefix) => prefix.name,
      // prefixed.MyWidget.named
      PropertyAccess(target: final PrefixedIdentifier target) =>
        target.identifier.name,
      final argument => throw Exception(
        'No constructor tear-off found in ${argument}',
      ),
    };
  }

  /// Gets the name of the invoked constructor of an [initializer], handling
  /// both plain invocations (`Meta(...)`) and ones with a `new`/`const`
  /// keyword (`const Meta(...)`).
  String? getConstructorName(Expression initializer) {
    return switch (initializer) {
      MethodInvocation(:final methodName) => methodName.name,
      InstanceCreationExpression(:final constructorName) =>
        constructorName.type.name.toString(),
      _ => null,
    };
  }
}
