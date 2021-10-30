import 'package:widgetbook_generator/code_generators/instances/primary_instance.dart';

/// Implements a [String] instance
class StringInstance extends PrimaryInstance<String> {
  const StringInstance.value(
    String value,
  ) : super(
          value: value,
        );

  @override
  String toCode() {
    return "'$value'";
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StringInstance && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'StringInstance(value: $value)';
}
