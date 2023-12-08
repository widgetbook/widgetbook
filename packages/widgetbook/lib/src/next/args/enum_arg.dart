import 'single_arg.dart';

class EnumArg<T extends Enum> extends SingleArg<T> {
  const EnumArg(
    super.value, {
    super.name,
    required super.values,
    super.labelBuilder = enumLabelBuilder,
  });

  static String enumLabelBuilder(Enum value) {
    return value.name;
  }

  @override
  EnumArg<T> init({
    required String name,
  }) {
    return EnumArg<T>(
      value,
      name: name,
      values: values,
      labelBuilder: labelBuilder,
    );
  }
}
