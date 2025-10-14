import '../core/arg.dart';
import '../fields/fields.dart';
import '../routing/routing.dart';

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
        name: 'value',
        values: values,
        initialValue: value,
        labelBuilder: labelBuilder ?? ObjectDropdownField.defaultLabelBuilder,
      ),
    ];
  }

  @override
  T valueFromQueryGroup(QueryGroup group) {
    return valueOf('value', group)!;
  }

  @override
  QueryGroup valueToQueryGroup(T value) {
    return {'value': paramOf('value', value)};
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
