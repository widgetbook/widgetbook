/// Annotates a function returning a Theme.
class WidgetbookTheme {
  /// Creates a new instance of [WidgetbookTheme].
  const WidgetbookTheme({
    required this.name,
    this.isDefault = false,
  });

  /// The name of the theme displayed in widgetbook.
  final String name;

  /// Specifies if this theme is the default
  ///
  /// If no default theme is specified the frist theme read by the generator
  /// will be the default.
  final bool isDefault;
}
