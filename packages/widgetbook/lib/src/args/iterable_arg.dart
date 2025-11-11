import '../core/arg.dart';
import '../fields/fields.dart';

class IterableArg<T> extends Arg<Iterable<T>> with SingleFieldOnly {
  IterableArg(
    super.value, {
    super.name,
    required this.values,
  });

  final Iterable<T> values;

  @override
  Field<Iterable<T>> get field {
    return IterableSegmentedField<T>(
      name: 'value',
      initialValue: value,
      values: values,
    );
  }
}

class NullableIterableArg<T> extends Arg<Iterable<T>?> with SingleFieldOnly {
  NullableIterableArg(
    super.value, {
    super.name,
    required this.values,
  });

  final Iterable<T> values;

  @override
  Field<Iterable<T>> get field {
    return IterableSegmentedField<T>(
      name: 'value',
      initialValue: value ?? [],
      values: values,
    );
  }
}
