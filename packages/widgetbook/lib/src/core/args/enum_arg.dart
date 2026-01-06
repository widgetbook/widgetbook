import 'single_arg.dart';

class EnumArg<T extends Enum> extends SingleArg<T> {
  EnumArg(
    super.value, {
    super.name,
    required super.values,
    super.labelBuilder = enumLabelBuilder,
    super.style = const DropdownSingleArgStyle(),
  });

  static String enumLabelBuilder(Enum value) {
    return value.name;
  }
}

class NullableEnumArg<T extends Enum> extends NullableSingleArg<T> {
  NullableEnumArg(
    super.value, {
    super.name,
    required super.values,
    super.labelBuilder = enumLabelBuilder,
    super.style = const DropdownSingleArgStyle(),
  });

  static String enumLabelBuilder(Enum value) {
    return value.name;
  }
}
