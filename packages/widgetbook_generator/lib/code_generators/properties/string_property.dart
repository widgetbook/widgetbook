import 'package:meta/meta.dart';
import 'package:widgetbook_generator/code_generators/properties/property.dart';

@immutable
class StringProperty extends Property {
  StringProperty({
    required String name,
    required this.value,
  }) : super(
          name: name,
        );

  final String value;

  @override
  String valueToCode() {
    return "'$value'";
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StringProperty &&
        other.value == value &&
        other.name == name;
  }

  @override
  int get hashCode => value.hashCode ^ name.hashCode;
}
