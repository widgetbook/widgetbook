import 'package:flutter/material.dart';

import '../state/state.dart';
import 'field_codec.dart';
import 'field_type.dart';

/// Base class for all input fields in Widgetbook.
///
/// [Field]s represent configurable inputs that appear in the settings panel
/// and allow users to customize addon behavior or knob values. Each field
/// can be serialized to JSON and synchronized with URL query parameters,
/// making the state shareable and persistent.
///
/// Fields are converted to:
/// 1. [Widget] through [toWidget] - used to display the input control in the settings panel
/// 2. [Map] through [toJson] - used to serialize the field configuration
///
/// Fields sync their changes with [WidgetbookState], which keeps them
/// synchronized with URL query parameters. A [Field] is encoded into query
/// parameters using a JSON-like format (e.g. `/?foo={bar:qux}`):
///
/// | Part   | Value |
/// | :----  | :---- |
/// | group  | `foo` |
/// | [name] | `bar` |
/// | value  | `qux` |
@optionalTypeArgs
abstract class Field<T> {
  /// Creates a [Field] with the specified configuration.
  const Field({
    required this.name,
    required this.type,
    required this.initialValue,
    required this.defaultValue,
    required this.codec,
    @Deprecated('Fields should not be aware of their context') this.onChanged,
  });

  /// Symbol used to represent nullable values in query parameters.
  static const nullabilitySymbol = '??';

  /// The unique identifier for this field within its group.
  final String name;

  /// Metadata about the field type.
  ///
  /// This helps external tools (like Widgetbook Cloud) understand what kind
  /// of input control to render for this field.
  final FieldType type;

  /// The default value when no value is specified.
  ///
  /// This value is used when the field is first created or when the
  /// query parameters don't contain a value for this field.
  final T? initialValue;

  /// The default value when the field has a null initialValue.
  ///
  /// This is useful for fields that are nullable and are toggled to non-null.
  final T defaultValue;

  /// Handles encoding and decoding field values to/from strings.
  final FieldCodec<T> codec;

  /// Converts the [defaultValue] to a string using the [codec].
  String get defaultValueStringified => codec.toParam(defaultValue);

  /// Converts the [initialValue] to a string using the [codec].
  String? get initialValueStringified =>
      initialValue == null ? null : codec.toParam(initialValue! as T);

  /// @nodoc
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

  /// Builds the current field into a [Widget] using [toWidget].
  Widget build(BuildContext context, String group) {
    final state = WidgetbookState.of(context);
    final groupMap = FieldCodec.decodeQueryGroup(state.queryParams[group]);
    final value = valueFrom(groupMap);

    return toWidget(context, group, value);
  }

  /// Converts this field into a [Widget] that can be used in the
  /// settings panel.
  Widget toWidget(BuildContext context, String group, T? value);

  /// Updates the field value in the [WidgetbookState] and synchronizes it
  /// with the URL query parameters.
  void updateField(BuildContext context, String group, T value) {
    final state = WidgetbookState.of(context);
    final stringifiedValue = codec.toParam(value);

    state.updateQueryField(
      group: group,
      field: name,
      value: stringifiedValue,
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
