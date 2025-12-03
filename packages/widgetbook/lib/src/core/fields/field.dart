import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

import '../routing/routing.dart';
import '../state/state.dart';
import '../utils.dart';
import 'color_field/color_picker.dart';
import 'color_field/color_space.dart';

part 'boolean_field.dart';
part 'color_field/color_field.dart';
part 'date_time_field.dart';
part 'double_input_field.dart';
part 'double_slider_field.dart';
part 'duration_field.dart';
part 'int_input_field.dart';
part 'int_slider_field.dart';
part 'iterable_segmented_field.dart';
part 'num_input_field.dart';
part 'num_slider_field.dart';
part 'object_dropdown_field.dart';
part 'object_segmented_field.dart';
part 'string_field.dart';

/// @nodoc
typedef LabelBuilder<T> = String Function(T value);

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
sealed class Field<T> {
  /// Creates a [Field] with the specified configuration.
  const Field({
    required this.name,
    required this.initialValue,
    required this.toParam,
    required this.toValue,
    @Deprecated('Fields should not be aware of their context') this.onChanged,
  });

  /// The unique identifier for this field within its group.
  final String name;

  /// The default value when no value is specified.
  ///
  /// This value is used when the field is first created or when the
  /// query parameters don't contain a value for this field.
  final T initialValue;

  /// Encoder for converting value of type [T] to a query parameter.
  final String Function(T value) toParam;

  /// Decoders for converting a query parameter to a value of type [T].
  /// Can return `null` if the parameter is invalid.
  final T? Function(String param) toValue;

  /// @nodoc
  @Deprecated('Fields should not be aware of their context')
  final void Function(BuildContext context, T? value)? onChanged;

  /// Extracts the value from [group],
  /// fallback to [initialValue] if field is not found or cannot be decoded.
  T valueFrom(QueryGroup? group) {
    final param = group?[name];
    if (param == null) return initialValue;

    return toValue(param) ?? initialValue;
  }

  /// Builds the current field into a [Widget] using [toWidget].
  Widget build(BuildContext context, String groupName) {
    final state = WidgetbookState.of(context);
    final group = state.queryGroups[groupName];
    final value = valueFrom(group);

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
    final param = toParam(value);

    state.updateQueryField(
      groupName: groupName,
      fieldName: name,
      fieldValue: param,
    );
  }

  /// Similar to [toParam] but without type safety.
  @internal
  String $unsafeToParam(dynamic value) => toParam(value as T);
}
