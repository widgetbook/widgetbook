/// Helper functions for serializing objects to JSON by including only non-default values.
///
/// These helpers ensure that the JSON output is minimal and contains only
/// meaningful data, excluding default/empty values.

/// Helper to add non-default string properties
void addString(Map<String, dynamic> properties, String key, String value) {
  if (value.isNotEmpty) properties[key] = value;
}

/// Helper to add non-zero integer properties
void addInt(Map<String, dynamic> properties, String key, int value) {
  if (value != 0) properties[key] = value;
}

/// Helper to add non-false boolean properties
void addBool(Map<String, dynamic> properties, String key, bool value) {
  if (value) properties[key] = value;
}

/// Helper to add non-default enum properties (as indices)
void addEnum(Map<String, dynamic> properties, String key, Enum? value) {
  if (value != null && value.index != 0) properties[key] = value.index;
}

/// Helper to add nullable properties with toString
void addNullableToString<T>(
  Map<String, dynamic> properties,
  String key,
  T? value,
) {
  if (value != null) properties[key] = value.toString();
}

/// Helper to add nullable properties as-is
void addNullable<T>(Map<String, dynamic> properties, String key, T? value) {
  if (value != null) properties[key] = value;
}

/// Helper to add non-empty collection properties
void addCollection<T>(
  Map<String, dynamic> properties,
  String key,
  Iterable<T>? collection, [
  dynamic Function(T)? map,
]) {
  if (collection != null && collection.isNotEmpty) {
    properties[key] = map != null
        ? collection.map(map).toList()
        : collection.toList();
  }
}
