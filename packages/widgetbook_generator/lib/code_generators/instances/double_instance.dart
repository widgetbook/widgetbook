import 'package:widgetbook_generator/code_generators/instances/primary_instance.dart';

/// Impelements a [double] instance
class DoubleInstance extends PrimaryInstance<double> {
  const DoubleInstance.value(double value)
      : super(
          value: value,
        );

  @override
  String toCode() {
    return value.toString();
  }
}
