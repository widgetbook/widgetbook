/// {@template widgetbook_exception}
/// An exception thrown by an internal widgetbook command.
/// {@endtemplate}
abstract class WidgetbookException implements Exception {
  /// {@macro widgetbook_exception}
  WidgetbookException(this.message);

  /// The error message which will be displayed to the user .
  final String message;

  @override
  String toString() => message;
}
