import '../core/arg.dart';
import '../fields/fields.dart';

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

  @override
  SingleArg<T> init({
    required String name,
  }) {
    return SingleArg<T>(
      value,
      name: $name ?? name,
      values: values,
      labelBuilder: labelBuilder,
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

  @override
  NullableSingleArg<T> init({
    required String name,
  }) {
    return NullableSingleArg<T>(
      value,
      name: $name ?? name,
      values: values,
      labelBuilder: labelBuilder,
    );
  }
}
