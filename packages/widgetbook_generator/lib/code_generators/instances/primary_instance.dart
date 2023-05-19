import 'base_instance.dart';

/// An abstract representation of a instance creating a primary datatype like
/// int, double, num, String or enums
abstract class PrimaryInstance<T> extends BaseInstance {
  /// Creates a new instance of [PrimaryInstance]
  const PrimaryInstance({required this.value});

  /// The value of the [PrimaryInstance]
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
