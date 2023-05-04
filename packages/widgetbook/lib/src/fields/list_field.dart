import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:widgetbook/src/fields/field_codec.dart';
import 'package:widgetbook/src/routing/router.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

import 'field.dart';
import 'field_type.dart';

class ListField<T> extends Field<T> {
  final List<T> values;
  final String Function(T value) labelBuilder;

  ListField({
    required super.group,
    required super.name,
    required this.values,
    required this.labelBuilder,
    required super.codec,
    required super.onChanged,
  }) : super(
          type: FieldType.list,
        );

  @override
  Widget build(BuildContext context) {
    final queryParams = GoRouterState.of(context).queryParams;
    final groupMap = FieldCodec.decodeQueryGroup(queryParams[group]);
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
}
