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
}
