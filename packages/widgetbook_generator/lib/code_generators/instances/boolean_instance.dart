import 'primary_instance.dart';

/// Implements a [bool] instance
class BooleanInstance extends PrimaryInstance<bool> {
  const BooleanInstance.value({
    required bool value,
  }) : super(
          value: value,
        );

  @override
  String toCode() {
    return value.toString();
  }
}
