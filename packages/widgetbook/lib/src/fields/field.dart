import 'package:flutter/material.dart';

import '../routing/routing.dart';
import '../state/state.dart';
import 'field_codec.dart';

/// Base class for all input fields in Widgetbook.
///
/// [Field]s represent configurable inputs that appear in the settings panel
/// and allow users to customize addon behavior or knob values. Each field
/// can be serialized to JSON and synchronized with URL query parameters,
/// making the state shareable and persistent.
///
/// Fields are converted to [Widget] through [toWidget]; used to display the
/// input control in the settings panel
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
    required this.initialValue,
    required this.codec,
    @Deprecated('Fields should not be aware of their context') this.onChanged,
  });

  /// The unique identifier for this field within its group.
  final String name;

  /// The default value when no value is specified.
  ///
  /// This value is used when the field is first created or when the
  /// query parameters don't contain a value for this field.
  final T initialValue;

  /// Handles encoding and decoding field values to/from strings.
  final FieldCodec<T> codec;

  /// @nodoc
  @Deprecated('Fields should not be aware of their context')
  final void Function(BuildContext context, T? value)? onChanged;

  /// Extracts the value from [group],
  /// fallback to [initialValue] if field is not found or cannot be decoded.
  T valueFrom(QueryGroup group) {
    final param = group[name];
    if (param == null) return initialValue;

    return codec.toValue(param) ?? initialValue;
  }

  /// Builds the current field into a [Widget] using [toWidget].
  Widget build(BuildContext context, String groupName) {
    final state = WidgetbookState.of(context);
    final group = state.queryGroups[groupName];
    final value = valueFrom(group ?? {});

    return toWidget(context, groupName, value);
  }

  /// Converts this field into a [Widget] that can be used in the
  /// settings panel.
  ///
  /// [value] is the current value of the field from the query group,
  /// or [initialValue] in case the field is not found in the group or couldn't
  /// be decoded.
  Widget toWidget(BuildContext context, String groupName, T value);

  /// Updates the field value in the [WidgetbookState] and synchronizes it
  /// with the URL query parameters.
  void updateField(BuildContext context, String groupName, T value) {
    final state = WidgetbookState.of(context);
    final stringifiedValue = codec.toParam(value);

    state.updateQueryField(
      groupName: groupName,
      fieldName: name,
      fieldValue: stringifiedValue,
    );
  }
}
