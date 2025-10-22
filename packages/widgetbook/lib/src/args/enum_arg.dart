import 'single_arg.dart';

class EnumArg<T extends Enum> extends SingleArg<T> {
  EnumArg(
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
      name: $name ?? name,
      values: values,
      labelBuilder: labelBuilder,
    );
  }
}

class NullableEnumArg<T extends Enum> extends NullableSingleArg<T> {
  NullableEnumArg(
    super.value, {
    super.name,
    required super.values,
    super.labelBuilder = enumLabelBuilder,
  });

  static String enumLabelBuilder(Enum value) {
    return value.name;
  }

  @override
  NullableEnumArg<T> init({
    required String name,
  }) {
    return NullableEnumArg<T>(
      value,
      name: $name ?? name,
      values: values,
      labelBuilder: labelBuilder,
    );
  }
}
