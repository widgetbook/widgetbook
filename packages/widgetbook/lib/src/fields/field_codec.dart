/// A codec for encoding and decoding field values to and from query parameters.
class FieldCodec<T> {
  /// Creates a [FieldCodec] with the specified encoding and decoding functions.
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

  /// Decodes [component] using [Uri.decodeComponent],
  /// but returns null if the decoding fails due to non-ASCII characters.
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

    final params = group
        .substring(1, group.length - 1)
        .split(RegExp(r',(?![^\[]*\])'));

    return Map<String, String>.fromEntries(
      params.map(
        (param) {
          final parts = param.split(':');
          final decodedKey = tryDecodeComponent(parts[0]);
          final decodedValue = tryDecodeComponent(parts[1]);

          return MapEntry(decodedKey ?? parts[0], decodedValue ?? parts[1]);
        },
      ),
    );
  }
}
