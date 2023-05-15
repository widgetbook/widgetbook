import 'package:flutter/widgets.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

import '../state/state.dart';
import 'field.dart';
import 'field_codec.dart';
import 'field_type.dart';

class DropdownField<T> extends Field<T> {
  DropdownField({
    required super.group,
    required super.name,
    required this.values,
    required super.initialValue,
    required this.labelBuilder,
    required super.codec,
    required super.onChanged,
  }) : super(
          type: FieldType.dropdown,
        );

  final List<T> values;
  final String Function(T value) labelBuilder;

  @override
  Widget build(BuildContext context) {
    final state = WidgetbookState.of(context);
    final groupMap = FieldCodec.decodeQueryGroup(state.queryParams[group]);
    final value = codec.toValue(groupMap[name]);

    // Notify change when field is built from new query params,
    // to keep query params and locale state (e.g. addon's setting) in sync.
    onChanged(value);

    return DropdownSetting<T>(
      options: values,
      initialSelection: value,
      optionValueBuilder: labelBuilder,
      onSelected: (value) {
        onChanged(value);

        final newGroupMap = Map<String, String>.from(groupMap)
          ..update(
            name,
            (_) => codec.toParam(value),
            ifAbsent: () => codec.toParam(value),
          );

        state.updateQueryParam(
          group,
          FieldCodec.encodeQueryGroup(newGroupMap),
        );
      },
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'values': values.map((codec.toParam)).toList(),
    };
  }
}
