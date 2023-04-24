/// Specifies the type of constructor used to create the widgetbook
enum Constructor {
  /// Generates a Widgetbook.material(...)
  material,

  /// Generates a Widgetbook.cupertino(...)
  cupertino,

  /// Generates a Widgetbook<T>(...)
  custom,
}

/// Extension to create a named constructor from the enum
extension ConstructorExtension on Constructor {
  /// transforms the enum into text
  String? get toCode {
    switch (this) {
      case Constructor.material:
        return 'material';
      case Constructor.cupertino:
        return 'cupertino';
      case Constructor.custom:
        return null;
    }
  }
}
