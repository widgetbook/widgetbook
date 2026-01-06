import '../fields/fields.dart';
import '../framework/arg.dart';

class DoubleArg extends StyledArg<double, DoubleArgStyle> with SingleFieldOnly {
  DoubleArg(
    super.value, {
    super.name,
    super.style = const InputDoubleArgStyle(),
  });

  @override
  Field<double> get field => style.toField(value);
}

class NullableDoubleArg extends StyledArg<double?, DoubleArgStyle>
    with SingleFieldOnly {
  NullableDoubleArg(
    super.value, {
    super.name,
    super.style = const InputDoubleArgStyle(),
  });

  @override
  Field<double> get field => style.toField(value ?? 0);
}

sealed class DoubleArgStyle extends ArgStyle<double> {
  const DoubleArgStyle();
}

final class InputDoubleArgStyle extends DoubleArgStyle {
  const InputDoubleArgStyle();

  @override
  Field<double> toField(double value) {
    return DoubleInputField(
      name: 'value',
      initialValue: value,
    );
  }
}

final class SliderDoubleArgStyle extends DoubleArgStyle {
  const SliderDoubleArgStyle({
    required this.min,
    required this.max,
    required this.divisions,
  });

  final double min;
  final double max;
  final int divisions;

  @override
  Field<double> toField(double value) {
    return DoubleSliderField(
      name: 'value',
      initialValue: value,
      min: min,
      max: max,
      divisions: divisions,
    );
  }
}
