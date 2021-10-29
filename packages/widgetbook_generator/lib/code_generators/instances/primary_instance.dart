import 'package:widgetbook_generator/code_generators/instances/base_instance.dart';

abstract class PrimaryInstance<T> extends BaseInstance {
  const PrimaryInstance({required this.value});
  final T value;

  @override
  String toString() => 'PrimaryInstance(value: $value)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PrimaryInstance<T> && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}
