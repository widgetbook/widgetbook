import '../core/arg.dart';
import '../fields/fields.dart';

class SingleArg<T> extends Arg<T> {
  const SingleArg(
    super.value, {
    super.name,
    required this.values,
    this.labelBuilder,
  });

  final List<T> values;
  final LabelBuilder<T>? labelBuilder;

  @override
  List<Field> get fields {
    return [
      ObjectDropdownField<T>(
        name: name,
        values: values,
        initialValue: value,
        labelBuilder: labelBuilder ?? ObjectDropdownField.defaultLabelBuilder,
      ),
    ];
  }

  @override
  T valueFromQueryGroup(Map<String, String> group) {
    return valueOf(name, group)!;
  }

  @override
  Map<String, String> valueToQueryGroup(T value) {
    return {name: paramOf(name, value)};
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
