import '../../../next.dart';
import '../../fields/fields.dart';

class EnumArg<T extends Enum> extends Arg<T> {
  const EnumArg({
    super.name,
    required super.value,
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
        labelBuilder: labelBuilder ?? ((value) => value.name),
      ),
    ];
  }

  @override
  T valueFromQueryGroup(Map<String, String> group) {
    return valueOf(name, group)!;
  }

  @override
  EnumArg<T> init({
    required String name,
  }) {
    return EnumArg<T>(
      name: name,
      value: value,
      values: values,
      labelBuilder: labelBuilder,
    );
  }
}
