/// A property which is set when a new instance is created
abstract class Property {
  // TODO rename name to key,
  // introduce a PropertyKey
  // and a PropertyValue since name is hella confusing
  Property({
    required this.key,
  });

  final String key;

  String valueToCode();

  String _nameToCode() {
    return key;
  }

  String toCode() {
    final value = valueToCode();
    final name = _nameToCode();
    return '$name: $value';
  }
}
