import 'package:flutter/foundation.dart';

class QueryGroup {
  const QueryGroup(
    this.fields, {
    this.isNullified = false,
  });

  /// Pattern to identify valid query group strings.
  /// Examples of valid strings: `{foo:bar}`, `??{foo:bar}`, `??`, `{}`
  static final pattern = RegExp(r'^\??\{.*\}$|^\?\?$');

  static const nullabilitySymbol = '??';
  static const QueryGroup empty = QueryGroup({});
  static const QueryGroup nullified = QueryGroup({}, isNullified: true);

  final bool isNullified;
  final Map<String, String> fields;

  String? operator [](String key) => fields[key];

  QueryGroup nullify() {
    return QueryGroup(
      fields,
      isNullified: true,
    );
  }

  QueryGroup unnullify() {
    return QueryGroup(fields);
  }

  /// Returns a copy of this query group with the given [name] field updated to
  /// the new [value]. If the field does not exist, it will be added.
  QueryGroup copyWithField(String name, String value) {
    final fieldsCopy = Map<String, String>.from(fields);
    fieldsCopy.update(name, (_) => value, ifAbsent: () => value);

    return QueryGroup(
      fieldsCopy,
      isNullified: isNullified,
    );
  }

  /// Decodes a string query group encoded value back to a [QueryGroup].
  // ignore: sort_constructors_first
  factory QueryGroup.fromParam(String value) {
    if (value == '{}') {
      return QueryGroup.empty;
    }

    if (value == nullabilitySymbol || value == '$nullabilitySymbol{}') {
      return QueryGroup.nullified;
    }

    final isNullified = value.startsWith(nullabilitySymbol);
    final params = value
        .substring(isNullified ? 3 : 1, value.length - 1)
        .split(',');
    final fields = Map<String, String>.fromEntries(
      params.map(
        (param) {
          final parts = param.split(':');
          final decodedKey = tryDecodeComponent(parts[0]);
          final decodedValue = tryDecodeComponent(parts[1]);

          return MapEntry(decodedKey ?? parts[0], decodedValue ?? parts[1]);
        },
      ),
    );

    return QueryGroup(
      fields,
      isNullified: isNullified,
    );
  }

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
  /// final encoded = encodeQueryGroup(queryGroup);
  ///
  /// print(encoded); // {foo:bar,baz:qux}
  /// ```
  String toParam() {
    final pairs = fields.entries.map((entry) {
      // Both key and value are encoded to ensure that reserved
      // characters (e.g. `:`, `{`, `}` and `,`) are not misinterpreted.
      // For example, using a comma in a string value or a colon
      // in a date value would break the decoding process.
      final encodedKey = Uri.encodeComponent(entry.key);
      final encodedValue = Uri.encodeComponent(entry.value);

      return '$encodedKey:$encodedValue';
    });

    return '${isNullified ? nullabilitySymbol : ''}{${pairs.join(',')}}';
  }

  @override
  int get hashCode => Object.hash(
    isNullified,
    Object.hashAll(fields.entries),
  );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is QueryGroup &&
        other.isNullified == isNullified &&
        mapEquals(other.fields, fields);
  }

  /// Encodes this [QueryGroup] into a JSON-like representation.
  /// If the query group is nullified, returns null.
  /// Otherwise, returns a map of its fields.
  Map<String, dynamic>? toJson() {
    return isNullified ? null : fields;
  }
}

/// Decodes [component] using [Uri.decodeComponent],
/// but returns null if the decoding fails due to non-ASCII characters.
String? tryDecodeComponent(String component) {
  try {
    return Uri.decodeComponent(component);
  } on ArgumentError {
    return null;
  }
}
