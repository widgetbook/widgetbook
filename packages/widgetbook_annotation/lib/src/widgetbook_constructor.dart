/// Specifies the type of constructor used to create the widgetbook
enum WidgetbookConstructor {
  /// Generates a Widgetbook.material(...)
  material,

  /// Generates a Widgetbook.cupertino(...)
  cupertino,

  /// Generates a Widgetbook<T>(...)
  custom,
}

/// Extension to create a named constructor from the enum
extension WidgetbookConstructorExtension on WidgetbookConstructor {
  /// transforms the enum into text
  String? get toCode {
    switch (this) {
      case WidgetbookConstructor.material:
        return 'material';
      case WidgetbookConstructor.cupertino:
        return 'cupertino';
      case WidgetbookConstructor.custom:
        return null;
    }
  }
}
