class FieldCodec<T> {
  const FieldCodec({
    required this.toParam,
    required this.toValue,
  });

  /// Encoder for converting value of type [T] to a query parameter.
  final String Function(T value) toParam;

  /// Decoders for converting a query parameter to a value of type [T].
  final T? Function(String? param) toValue;

  /// Encodes a query group into a JSON-like representation.
  ///
  /// Example:
  ///
  /// ```
  /// final queryGroup = {
  ///   'foo': 'bar',
  ///   'baz': 'qux',
  /// };
  ///
  /// final encoded = FieldCodec.encodeQueryGroup(queryGroup);
  ///
  /// print(encoded); // {foo:bar,baz:qux}
  /// ```
  static String encodeQueryGroup(Map<String, String> group) {
    final pairs = group.entries.map((entry) {
      final String encodedKey = Uri.encodeComponent(entry.key);
      return '$encodedKey:${entry.value}';
    });
    return '{${pairs.join(',')}}';
  }

  /// Decodes a query group encoded value back to a [Map].
  static Map<String, String> decodeQueryGroup(String? group) {
    if (group == null) return {};

    final params = group.substring(1, group.length - 1).split(',');

    return Map<String, String>.fromEntries(
      params.map(
        (param) {
          final parts = param.split(':');
          final String decodedKey = Uri.decodeComponent(parts[0]);
          return MapEntry(decodedKey, parts[1]);
        },
      ),
    );
  }
}
