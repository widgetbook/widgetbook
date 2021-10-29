import 'package:widgetbook_generator/code_generators/instances/primary_instance.dart';

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
