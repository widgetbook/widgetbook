enum WidgetbookConstructor {
  material,
  cupertino,
  custom,
}

/// Extension to create a named constructor from the enum
extension WidgetbookConstructorExtension on WidgetbookConstructor {
  ///
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
