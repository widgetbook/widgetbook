import 'package:meta/meta.dart';
import 'package:widgetbook_generator/code_generators/instances/base_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/boolean_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/string_instance.dart';

/// A property which is set when a new instance is created
@immutable
class Property {
  const Property({
    required this.key,
    required this.instance,
  });

  Property.string({
    required this.key,
    required String value,
  }) : instance = StringInstance.value(value);

  Property.bool({
    required this.key,
    required bool value,
  }) : instance = BooleanInstance.value(value: value);

  final String key;
  final BaseInstance instance;

  String _instanceToCode() => instance.toCode();

  String _nameToCode() {
    return key;
  }

  String toCode() {
    final value = _instanceToCode();
    final name = _nameToCode();
    return '$name: $value';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Property && other.key == key && other.instance == instance;
  }

  @override
  int get hashCode => key.hashCode ^ instance.hashCode;

  @override
  String toString() => 'Property(key: $key, instance: $instance)';
}
