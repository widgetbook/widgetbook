abstract class Property {
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
