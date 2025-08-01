/// A class representing a theme in Widgetbook.
class WidgetbookTheme<T> {
  /// Creates a new instance of [WidgetbookTheme].
  const WidgetbookTheme({
    required this.name,
    required this.data,
  });

  /// The name of the theme.
  final String name;

  /// The theme data associated with this theme.
  final T data;

  @override
  bool operator ==(covariant WidgetbookTheme<T> other) {
    if (identical(this, other)) return true;

    return other.name == name && other.data == data;
  }

  @override
  int get hashCode => name.hashCode ^ data.hashCode;
}
