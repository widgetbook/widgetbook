import 'package:widgetbook_generator/code_generators/instances/primary_instance.dart';

/// Implements a [bool] instance
class BooleanInstance extends PrimaryInstance<bool> {
  const BooleanInstance.value(bool value)
      : super(
          value: value,
        );

  @override
  String toCode() {
    return value.toString();
  }
}
