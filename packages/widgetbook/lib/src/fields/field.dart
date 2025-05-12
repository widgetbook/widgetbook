import 'package:flutter/material.dart';

import '../state/state.dart';
import 'field_codec.dart';
import 'field_type.dart';

/// [Field]s are data representation of inputs that are used in the settings
/// panel. They should be convertible to:
///
/// 1. [Widget] through [toWidget]; used to display this in the settings panel.
/// 2. [Map] through [toJson]; used to send a JSON-representation of the field.
///
/// [Field]s keep their changes in sync with [WidgetbookState] which syncs them
/// with the query parameters. A [Field] is encoded into a query parameter using
/// a JSON-like format (e.g. `/?foo={bar:qux}`), it has the following parts:
///
/// | Part   | Value |
/// | :----  | :---- |
/// | group  | `foo` |
/// | [name] | `bar` |
/// | value  | `qux` |
@optionalTypeArgs
abstract class Field<T> {
  const Field({
    required this.name,
    required this.type,
    required this.initialValue,
    required this.codec,
    @Deprecated('Fields should not be aware of their context') this.onChanged,
  });

  static const nullabilitySymbol = '??';

  /// Name of this inside the query group.
  final String name;

  /// Type of this, helps providing some metadata about this,
  /// to help rendering proper widget by external listeners.
  final FieldType type;

  final T? initialValue;

  /// Encodes the value of Type [T] to a [String] format, to be used in
  /// a query parameter, or decodes a [String] query parameter back to [T].
  final FieldCodec<T> codec;

  /// Callback for when [Field]'s value changed through:
  /// 1. [WidgetbookState.queryParams], used for deep linking.
  /// 2. [Field]'s widget from the side panel.
  @Deprecated('Fields should not be aware of their context')
  final void Function(BuildContext context, T? value)? onChanged;

  /// A field is considered nullable if the param's value starts
  /// with [nullabilitySymbol].
  bool isNull(Map<String, String> groupMap) {
    final param = groupMap[name];
    return param?.startsWith(nullabilitySymbol) ?? false;
  }

  /// Extracts the value from [groupMap],
  /// fallback to [initialValue] if not found.
  /// If the field value starts with [nullabilitySymbol], it will be
  /// interpreted as null.
  T? valueFrom(Map<String, String> groupMap) {
    if (isNull(groupMap)) return null;
    return codec.toValue(groupMap[name]) ?? initialValue;
  }

  Widget build(BuildContext context, String group) {
    final state = WidgetbookState.of(context);
    final groupMap = FieldCodec.decodeQueryGroup(state.queryParams[group]);
    final value = valueFrom(groupMap);

    return toWidget(context, group, value);
  }

  /// Builds the current field into a [Widget] to be used for input in the
  /// side panel.
  Widget toWidget(BuildContext context, String group, T? value);

  void updateField(BuildContext context, String group, T value) {
    final state = WidgetbookState.of(context);
    final groupMap = FieldCodec.decodeQueryGroup(state.queryParams[group]);

    // Preserve the nullability symbol in the new value if the previous
    // value was null (i.e. had the nullability symbol).
    final rawNewValue = codec.toParam(value);
    final newValue = isNull(groupMap)
        ? '${Field.nullabilitySymbol}$rawNewValue'
        : rawNewValue;

    state.updateQueryField(
      group: group,
      field: name,
      value: newValue,
    );
  }

  /// Same as [toJson] put prepends some metadata like [name], [type] and value.
  Map<String, dynamic> toFullJson() {
    final _value = initialValue; // local variable promotion

    return {
      'name': name,
      'type': type.name,
      'value': _value == null ? null : codec.toParam(_value),
      ...toJson(),
    };
  }

  /// Converts this into JSON representation share information about the
  /// available fields. Mostly used to support [Field]s on Widgetbook Cloud.
  Map<String, dynamic> toJson() => {};
}
