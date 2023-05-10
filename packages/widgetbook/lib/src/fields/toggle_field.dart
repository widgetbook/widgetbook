import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:widgetbook/src/routing/router.dart';

import 'field.dart';
import 'field_codec.dart';
import 'field_type.dart';

class ToggleField extends Field<bool> {
  ToggleField({
    required super.group,
    required super.name,
    super.initialValue = true,
    required super.onChanged,
  }) : super(
          type: FieldType.toggle,
          codec: FieldCodec(
            toParam: (value) => value.toString(),
            toValue: (param) => param == 'true',
          ),
        );

  @override
  Widget build(BuildContext context) {
    final queryParams = GoRouterState.of(context).queryParams;
    final groupMap = FieldCodec.decodeQueryGroup(queryParams[group]);
    final value = codec.toValue(groupMap[name]);

    // Notify change when field is built from new query params,
    // to keep query params and locale state (e.g. addon's setting) in sync.
    onChanged(context, value);

    return Switch(
      value: value ?? initialValue,
      onChanged: (value) {
        onChanged(context, value);

        final router = GoRouter.of(context);
        final newGroupMap = Map<String, String>.from(groupMap)
          ..update(
            name,
            (_) => codec.toParam(value),
            ifAbsent: () => codec.toParam(value),
          );

        router.updateQueryParam(
          group,
          FieldCodec.encodeQueryGroup(newGroupMap),
        );
      },
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'value': initialValue,
    };
  }
}
