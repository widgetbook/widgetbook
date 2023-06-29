import 'primary_instance.dart';

/// Implements a [bool] instance
class BooleanInstance extends PrimaryInstance<bool> {
  const BooleanInstance.value({
    required super.value,
  });

  @override
  String toCode() {
    return value.toString();
  }
}
