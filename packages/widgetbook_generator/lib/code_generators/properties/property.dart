abstract class Property {
  // TODO rename name to key,
  // introduce a PropertyKey
  // and a PropertyValue since name is hella confusing
  Property({
    required this.name,
  });

  final String name;

  String valueToCode();

  String _nameToCode() {
    return name;
  }

  String toCode() {
    final value = valueToCode();
    final name = _nameToCode();
    return '$name: $value';
  }
}
