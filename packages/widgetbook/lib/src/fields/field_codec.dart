class FieldCodec<T> {
  const FieldCodec({
    required this.toParam,
    required this.toValue,
  });

  final String Function(T value) toParam;
  final T? Function(String? param) toValue;

  static String encodeQueryGroup(Map<String, String> group) {
    final pairs = group.entries.map((entry) => '${entry.key}:${entry.value}');
    return '{${pairs.join(',')}}';
  }

  static Map<String, String> decodeQueryGroup(String? group) {
    if (group == null) return {};

    final params = group.substring(1, group.length - 1).split(',');

    return Map<String, String>.fromEntries(
      params.map(
        (param) {
          final parts = param.split(':');
          return MapEntry(parts[0], parts[1]);
        },
      ),
    );
  }
}
