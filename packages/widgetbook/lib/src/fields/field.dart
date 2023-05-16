import 'package:flutter/material.dart';

import '../state/state.dart';
import 'field_codec.dart';
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

  final T? initialValue;

  final FieldCodec<T> codec;

  final void Function(BuildContext context, T? value) onChanged;

  Widget build(BuildContext context) {
    final state = WidgetbookState.of(context);
    final groupMap = FieldCodec.decodeQueryGroup(state.queryParams[group]);
    final value = codec.toValue(groupMap[name]);

    // TODO: remove this workaround
    if (group != 'knobs') {
      // Notify change when field is built from new query params,
      // to keep query params and locale state (e.g. addon's setting) in sync.
      onChanged(context, value);
    }

    return toWidget(context, value);
  }

  Widget toWidget(BuildContext context, T? value);

  void updateField(BuildContext context, T value) {
    final state = WidgetbookState.of(context);
    final groupMap = FieldCodec.decodeQueryGroup(state.queryParams[group]);

    final newGroupMap = Map<String, String>.from(groupMap)
      ..update(
        name,
        (_) => codec.toParam(value),
        ifAbsent: () => codec.toParam(value),
      );

    onChanged(context, value);

    state.updateQueryParam(
      group,
      FieldCodec.encodeQueryGroup(newGroupMap),
    );
  }

  Map<String, dynamic> toFullJson() {
    return {
      'name': name,
      'type': type.name,
      'initialValue':
          initialValue == null ? null : codec.toParam(initialValue!),
      ...toJson(),
    };
  }

  Map<String, dynamic> toJson();
}
