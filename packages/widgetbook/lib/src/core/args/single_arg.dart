import '../fields/fields.dart';
import '../framework/arg.dart';

class SingleArg<T> extends Arg<T> with SingleFieldOnly {
  SingleArg(
    super.value, {
    super.name,
    required this.values,
    this.labelBuilder,
  });

  final List<T> values;
  final LabelBuilder<T>? labelBuilder;

  @override
  Field<T> get field {
    return ObjectDropdownField<T>(
      name: 'value',
      values: values,
      initialValue: value,
      labelBuilder: labelBuilder ?? ObjectDropdownField.defaultLabelBuilder,
    );
  }
}

class NullableSingleArg<T> extends Arg<T?> with SingleFieldOnly {
  NullableSingleArg(
    super.value, {
    super.name,
    required this.values,
    this.labelBuilder,
  });

  final List<T> values;
  final LabelBuilder<T>? labelBuilder;

  @override
  Field<T> get field {
    return ObjectDropdownField<T>(
      name: 'value',
      values: values,
      initialValue: value ?? values.first,
      labelBuilder: labelBuilder ?? ObjectDropdownField.defaultLabelBuilder,
    );
  }
}
