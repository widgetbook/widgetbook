import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:widgetbook/src/routing/router.dart';

import 'field.dart';
import 'field_codec.dart';
import 'field_type.dart';

class ColorField extends Field<Color> {
  ColorField({
    required super.group,
    required super.name,
    super.initialValue = Colors.white,
    required super.onChanged,
  }) : super(
          type: FieldType.color,
          codec: FieldCodec(
            toParam: (color) => color.value.toRadixString(16),
            toValue: (param) => Color(
              int.parse(
                param ?? '0',
                radix: 16,
              ),
            ),
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

    return TextFormField(
      initialValue: codec.toParam(value ?? initialValue),
      onChanged: (value) {
        final color = codec.toValue(value) ?? initialValue;
        onChanged(context, color);

        final router = GoRouter.of(context);
        final newGroupMap = Map<String, String>.from(groupMap)
          ..update(
            name,
            (_) => codec.toParam(color),
            ifAbsent: () => codec.toParam(color),
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
      'value': codec.toParam(initialValue),
    };
  }
}
