// next version of Widgetbook doesn't have api docs yet
// ignore_for_file: public_member_api_docs

import '../../../next.dart';
import '../../fields/fields.dart';

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
      ListField<T>(
        name: name,
        values: values,
        initialValue: value,
        labelBuilder: labelBuilder ?? ListField.defaultLabelBuilder,
      ),
    ];
  }

  @override
  T valueFromQueryGroup(Map<String, String> group) {
    return valueOf(name, group)!;
  }

  @override
  SingleArg<T> init({
    required String name,
  }) {
    return SingleArg<T>(
      value,
      name: $name == null ? name : $name,
      values: values,
      labelBuilder: labelBuilder,
    );
  }
}
