import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:widgetbook/src/routing/router.dart';

import 'field.dart';
import 'field_codec.dart';
import 'field_type.dart';

class SliderField extends Field<double> {
  SliderField({
    required super.group,
    required super.name,
    super.initialValue = 0,
    required this.min,
    required this.max,
    this.divisions,
    required super.onChanged,
  }) : super(
          type: FieldType.text,
          codec: FieldCodec(
            toParam: (value) => value.toString(),
            toValue: (param) => double.tryParse(param ?? ''),
          ),
        );

  final double min;
  final double max;
  final int? divisions;

  @override
  Widget build(BuildContext context) {
    final queryParams = GoRouterState.of(context).queryParams;
    final groupMap = FieldCodec.decodeQueryGroup(queryParams[group]);
    final value = codec.toValue(groupMap[name]);

    // Notify change when field is built from new query params,
    // to keep query params and locale state (e.g. addon's setting) in sync.
    onChanged(context, value);

    return Slider(
      value: value ?? initialValue,
      min: min,
      max: max,
      label: (value ?? initialValue).toStringAsFixed(2),
      divisions: divisions,
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
      'min': min,
      'max': max,
      'divisions': divisions,
    };
  }
}
