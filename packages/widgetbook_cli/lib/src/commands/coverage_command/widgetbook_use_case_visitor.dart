part of 'coverage_command.dart';

class WidgetbookUsecaseVisitor extends GeneralizingAstVisitor<void> {
  WidgetbookUsecaseVisitor();

  final List<String> usecases = <String>[];

  @override
  void visitAnnotation(Annotation node) {
    // Check if the annotation's constructor name is 'UseCase'
    // using contains because user could use widgetbook.UseCase
    // or w.UseCase etc.
    if (!node.name.name.contains('UseCase')) return;

    var arguments = node.arguments?.arguments;
    if (arguments == null) return;

    for (var argument in arguments) {
      // Extract the named 'type' argument value from the annotation
      // and add it to the usecases list
      if (argument is NamedExpression && argument.name.label.name == 'type') {
        usecases.add(argument.expression.toString());
      }
    }

    super.visitAnnotation(node);
  }
}
