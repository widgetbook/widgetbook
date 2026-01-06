import '../fields/fields.dart';
import '../framework/arg.dart';

class DoubleArg extends StyledArg<double, DoubleArgStyle> with SingleFieldOnly {
  DoubleArg(
    super.value, {
    super.name,
    super.style = const InputDoubleArgStyle(),
  });

  @override
  Field<double> get field {
    return switch (style) {
      InputDoubleArgStyle() => DoubleInputField(
        name: 'value',
        initialValue: value,
      ),
      SliderDoubleArgStyle s => DoubleSliderField(
        name: 'value',
        initialValue: value,
        min: s.min,
        max: s.max,
        divisions: s.divisions,
      ),
    };
  }
}

class NullableDoubleArg extends StyledArg<double?, DoubleArgStyle>
    with SingleFieldOnly {
  NullableDoubleArg(
    super.value, {
    super.name,
    super.style = const InputDoubleArgStyle(),
  });

  @override
  Field<double> get field {
    return switch (style) {
      InputDoubleArgStyle() => DoubleInputField(
        name: 'value',
        initialValue: value ?? 0.0,
      ),
      SliderDoubleArgStyle s => DoubleSliderField(
        name: 'value',
        initialValue: value ?? 0.0,
        min: s.min,
        max: s.max,
        divisions: s.divisions,
      ),
    };
  }
}

sealed class DoubleArgStyle {
  const DoubleArgStyle();
}

final class InputDoubleArgStyle extends DoubleArgStyle {
  const InputDoubleArgStyle();
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
}
