import 'package:flutter/material.dart';

import '../integrations/integrations.dart';
import '../state/state.dart';
import 'field_codec.dart';
import 'field_type.dart';

/// [Field]s are data representation of inputs that are used in the settings
/// panel. They should be convertible to:
///
/// 1. [Widget] through [toWidget]; used to display this in the settings panel.
/// 2. [Map] through [toJson]; used to send a JSON-representation of the field
/// to be interpreted by [WidgetbookCloudIntegration].
///
/// [Field]s keep their changes in sync with [WidgetbookState] which syncs them
/// with the query parameters. A [Field] is encoded into a query parameter using
/// a JSON-like format (e.g. `/?foo={bar:qux}`), it has the following parts:
///
/// | Part    | Value |
/// | :-----  | :---- |
/// | [group] | `foo` |
/// | [name]  | `bar` |
/// | value   | `qux` |
abstract class Field<T> {
  const Field({
    required this.group,
    required this.name,
    required this.type,
    required this.initialValue,
    required this.codec,
    required this.onChanged,
  });

  /// A set of [Field]s can be grouped under the same query parameter
  /// by using [group] for all of them.
  final String group;

  /// Name of this inside the [group] query parameter.
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

  /// Builds the current field into a [Widget] to be used for input in the
  /// side panel.
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

  /// Same as [toJson] put prepends some metadata like [name], [type] and value.
  Map<String, dynamic> toFullJson() {
    return {
      'name': name,
      'type': type.name,
      'value': initialValue == null ? null : codec.toParam(initialValue!),
      ...toJson(),
    };
  }

  /// Converts this into JSON representation share information about the
  /// available fields. Mostly used to support [Field]s on Widgetbook Cloud.
  Map<String, dynamic> toJson() => {};
}
