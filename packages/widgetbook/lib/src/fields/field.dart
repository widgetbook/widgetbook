import 'package:flutter/material.dart';
import 'package:widgetbook/src/fields/field_codec.dart';
import 'field_type.dart';

abstract class Field<T> {
  const Field({
    required this.group,
    required this.name,
    required this.type,
    required this.initialValue,
    required this.codec,
    required this.onChanged,
  });

  final String group;

  /// Name of this in the query parameter group.
  ///
  /// For example, the query param `/?foo={bar:qux}`,
  /// has the following parts:
  ///
  /// | Part           | Value |
  /// | :------------  | :---- |
  /// | Group          | `foo` |
  /// | Field[0] name  | `bar` |
  /// | Field[0] value | `qux` |
  final String name;

  /// Type of this, helps providing some metadata about this,
  /// to help rendering proper widget by external listeners.
  final FieldType type;

  final T initialValue;

  final FieldCodec<T> codec;

  final void Function(T? value) onChanged;

  Widget build(BuildContext context);

  Map<String, dynamic> toFullJson() {
    return {
      'name': name,
      'type': type.name,
      'initialValue': codec.toParam(initialValue),
      ...toJson(),
    };
  }

  Map<String, dynamic> toJson();
}
