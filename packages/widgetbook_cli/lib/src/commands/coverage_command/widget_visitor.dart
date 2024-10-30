part of 'coverage_command.dart';

class WidgetVisitor extends GeneralizingAstVisitor<void> {
  WidgetVisitor();

  final List<String> widgets = <String>[];

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    // Start by getting the superclass name
    final superClass = node.extendsClause?.superclass;

    // - if there's no super class then it is not a widget
    // - if the node does not have a declared element then the analyzer doesn't
    //  have enough information to determine if it is a widget
    // - if the class is not a widget then we don't need to add it to the list
    if (superClass == null) return;
    if (node.declaredElement == null) return;
    if (!_isWidgetClass(node.declaredElement!)) return;

    widgets.add(node.name.toString());

    super.visitClassDeclaration(node);
  }

  /// Recursively checks if the class extends a widget
  /// by traversing up the class hierarchy
  bool _isWidgetClass(ClassElement classElement) {
    final superType = classElement.supertype;

    // If there's no superclass, it's not a widget
    if (superType == null) return false;

    final superClassName = superType.element.name;

    // Check if this class directly extends StatelessWidget or StatefulWidget
    if (superClassName == 'StatelessWidget' ||
        superClassName == 'StatefulWidget' ||
        superClassName == 'Widget') {
      return true;
    }

    // If not, recursively check the superclass
    final interfaceElement = superType.element;
    if (interfaceElement is! ClassElement) {
      return false;
    }
    return _isWidgetClass(interfaceElement);
  }
}
