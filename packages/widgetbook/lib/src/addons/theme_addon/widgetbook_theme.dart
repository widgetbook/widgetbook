class WidgetbookTheme<T> {
  const WidgetbookTheme({
    required this.name,
    required this.data,
  });

  final String name;
  final T data;

  @override
  bool operator ==(covariant WidgetbookTheme<T> other) {
    if (identical(this, other)) return true;

    return other.name == name && other.data == data;
  }

  @override
  int get hashCode => name.hashCode ^ data.hashCode;
}
