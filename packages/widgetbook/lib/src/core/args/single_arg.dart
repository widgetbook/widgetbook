import '../fields/fields.dart';
import '../framework/arg.dart';

class SingleArg<T> extends StyledArg<T, SingleArgStyle> with SingleFieldOnly {
  SingleArg(
    super.value, {
    super.name,
    required this.values,
    this.labelBuilder,
    super.style = const DropdownSingleArgStyle(),
  });

  final List<T> values;
  final LabelBuilder<T>? labelBuilder;

  @override
  Field<T> get field {
    return switch (style) {
      DropdownSingleArgStyle() => ObjectDropdownField<T>(
        name: 'value',
        values: values,
        initialValue: value,
        labelBuilder: labelBuilder ?? ObjectDropdownField.defaultLabelBuilder,
      ),
      SegmentedSingleArgStyle() => ObjectSegmentedField<T>(
        name: 'value',
        values: values,
        initialValue: value,
        labelBuilder: labelBuilder ?? ObjectSegmentedField.defaultLabelBuilder,
      ),
    };
  }
}

class NullableSingleArg<T> extends StyledArg<T?, SingleArgStyle>
    with SingleFieldOnly {
  NullableSingleArg(
    super.value, {
    super.name,
    required this.values,
    this.labelBuilder,
    super.style = const DropdownSingleArgStyle(),
  });

  final List<T> values;
  final LabelBuilder<T>? labelBuilder;

  @override
  Field<T> get field {
    return switch (style) {
      DropdownSingleArgStyle() => ObjectDropdownField<T>(
        name: 'value',
        values: values,
        initialValue: value,
        labelBuilder: labelBuilder ?? ObjectDropdownField.defaultLabelBuilder,
      ),
      SegmentedSingleArgStyle() => ObjectSegmentedField<T>(
        name: 'value',
        values: values,
        initialValue: value,
        labelBuilder: labelBuilder ?? ObjectSegmentedField.defaultLabelBuilder,
      ),
    };
  }
}

sealed class SingleArgStyle {
  const SingleArgStyle();
}

final class DropdownSingleArgStyle extends SingleArgStyle {
  const DropdownSingleArgStyle();
}

final class SegmentedSingleArgStyle extends SingleArgStyle {
  const SegmentedSingleArgStyle();
}
