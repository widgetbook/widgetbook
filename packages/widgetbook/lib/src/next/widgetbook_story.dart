import 'package:flutter/material.dart';

import '../fields/fields.dart';
import '../navigation/nodes/nodes.dart' as v3;
import '../state/state.dart';
import 'widgetbook_args.dart';

@optionalTypeArgs
class WidgetbookStory<TWidget> extends v3.WidgetbookUseCase {
  WidgetbookStory({
    required super.name,
    required this.args,
    super.designLink,
  }) : super(
          builder: (context) {
            final state = WidgetbookState.of(context);
            final groupMap = FieldCodec.decodeQueryGroup(
              state.queryParams['args'],
            );

            return args.build(context, groupMap);
          },
        );

  final WidgetbookArgs<TWidget> args;

  @override
  WidgetbookStory<TWidget> copyWith({
    String? name,
    List<v3.WidgetbookNode>? children,
  }) {
    return this;
  }
}
