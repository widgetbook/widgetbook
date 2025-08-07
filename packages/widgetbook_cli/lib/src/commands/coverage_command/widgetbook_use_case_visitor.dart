part of 'coverage_command.dart';

class UseCaseVisitor extends GeneralizingAstVisitor<void> {
  UseCaseVisitor();

  final Set<String> components = <String>{};

  @override
  void visitAnnotation(Annotation node) {
    // Check if the annotation's constructor name is 'UseCase'
    // using contains because user could use widgetbook.UseCase
    // or w.UseCase etc.
    if (!node.name.name.contains('UseCase')) return;

    var arguments = node.arguments?.arguments;
    if (arguments == null) return;

    final componentArgument = arguments
        .whereType<NamedExpression>()
        .firstWhereOrNull((arg) => arg.name.label.name == 'type');

    final component = componentArgument?.expression.toString();

    if (component != null) {
      components.add(component);
    }

    super.visitAnnotation(node);
  }
}
