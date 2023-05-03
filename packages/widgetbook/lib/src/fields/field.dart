import 'package:flutter/material.dart';
import 'field_type.dart';

abstract class Field<T> {
  const Field({
    required this.name,
    required this.type,
    required this.onChanged,
  });

  /// Name of this in the query parameter group.
  ///
  /// For example, the query param `/?foo={bar:qux}`,
  /// has the following parts:
  ///
  /// | Part           | Value |
  /// | :------------  | :---- |
  /// | Group name     | `foo` |
  /// | Field[0] name  | `bar` |
  /// | Field[0] value | `qux` |
  final String name;

  /// Type of this, helps providing some metadata about this,
  /// to help rendering proper widget by external listeners.
  final FieldType type;

  final void Function(T value) onChanged;

  Widget build(BuildContext context);
}
