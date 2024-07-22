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
      // Both key and value are encoded to ensure that reserved
      // characters (e.g. `:`, `{`, `}` and `,`) are not misinterpreted.
      // For example, using a comma in a string value or a colon
      // in a date value would break the decoding process.
      final encodedKey = Uri.encodeComponent(entry.key);
      final encodedValue = Uri.encodeComponent(entry.value);

      return '$encodedKey:$encodedValue';
    });

    return '{${pairs.join(',')}}';
  }

  /// Tring to decode [component] if possible.
  ///
  /// If not possible returned null.
  static String? tryDecodeComponent(String component) {
    try {
      return Uri.decodeComponent(component);
    } on ArgumentError {
      return null;
    }
  }

  /// Decodes a query group encoded value back to a [Map].
  static Map<String, String> decodeQueryGroup(String? group) {
    if (group == null || group == '{}') return {};

    final params = group.substring(1, group.length - 1).split(',');
    final filteredParams =
        params.where((p) => p.split(':').length == 2).map((p) => p.split(':'));

    return Map<String, String>.fromEntries(
      filteredParams.map(
        (parts) {
          final decodedKey = tryDecodeComponent(parts[0]);
          final decodedValue = tryDecodeComponent(parts[1]);
          return MapEntry(decodedKey ?? parts[0], decodedValue ?? parts[1]);
        },
      ),
    );
  }
}
