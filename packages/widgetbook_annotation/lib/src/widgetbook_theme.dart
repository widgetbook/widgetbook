/// Annotates a function returning a Theme.
class WidgetbookTheme {
  /// Creates an annotation for a dark theme.
  /// Only one theme must me annotated.
  const WidgetbookTheme.dark() : isDarkTheme = true;

  /// Creates an annotation for a light theme.
  /// Only one theme must me annotated.
  const WidgetbookTheme.light() : isDarkTheme = false;

  /// Defines whether the annotated function is a dark theme.
  final bool isDarkTheme;
}
