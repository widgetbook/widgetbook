import '../fields/fields.dart';
import '../framework/arg.dart';

class IntArg extends StyledArg<int, IntArgStyle> with SingleFieldOnly {
  IntArg(
    super.value, {
    super.name,
    super.style = const InputIntArgStyle(),
  });

  @override
  Field<int> get field => style.toField(value);
}

class NullableIntArg extends StyledArg<int?, IntArgStyle> with SingleFieldOnly {
  NullableIntArg(
    super.value, {
    super.name,
    super.style = const InputIntArgStyle(),
  });

  @override
  Field<int> get field => style.toField(value ?? 0);
}

sealed class IntArgStyle extends ArgStyle<int> {
  const IntArgStyle();
}

final class InputIntArgStyle extends IntArgStyle {
  const InputIntArgStyle();

  @override
  Field<int> toField(int value) {
    return IntInputField(
      name: 'value',
      initialValue: value,
    );
  }
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

  @override
  Field<int> toField(int value) {
    return IntSliderField(
      name: 'value',
      initialValue: value,
      min: min,
      max: max,
      divisions: divisions,
    );
  }
}
