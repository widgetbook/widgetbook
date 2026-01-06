import '../fields/fields.dart';
import '../framework/arg.dart';

class IntArg extends StyledArg<int, IntArgStyle> with SingleFieldOnly {
  IntArg(
    super.value, {
    super.name,
    super.style = const InputIntArgStyle(),
  });

  @override
  Field<int> get field {
    return switch (style) {
      InputIntArgStyle() => IntInputField(
        name: 'value',
        initialValue: value,
      ),
      SliderIntArgStyle s => IntSliderField(
        name: 'value',
        initialValue: value,
        min: s.min,
        max: s.max,
        divisions: s.divisions,
      ),
    };
  }
}

class NullableIntArg extends StyledArg<int?, IntArgStyle> with SingleFieldOnly {
  NullableIntArg(
    super.value, {
    super.name,
    super.style = const InputIntArgStyle(),
  });

  @override
  Field<int> get field {
    return switch (style) {
      InputIntArgStyle() => IntInputField(
        name: 'value',
        initialValue: value ?? 0,
      ),
      SliderIntArgStyle s => IntSliderField(
        name: 'value',
        initialValue: value ?? 0,
        min: s.min,
        max: s.max,
        divisions: s.divisions,
      ),
    };
  }
}

sealed class IntArgStyle {
  const IntArgStyle();
}

final class InputIntArgStyle extends IntArgStyle {
  const InputIntArgStyle();
}

final class SliderIntArgStyle extends IntArgStyle {
  const SliderIntArgStyle({
    required this.min,
    required this.max,
    required this.divisions,
  });

  final int min;
  final int max;
  final int divisions;
}
