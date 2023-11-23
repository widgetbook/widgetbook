import 'package:flutter/material.dart';

import '../fields/fields.dart';
import '../navigation/nodes/nodes.dart';
import '../state/state.dart';
import 'widgetbook_args.dart';

@optionalTypeArgs
class WidgetbookStory<TWidget, TArgs extends WidgetbookArgs<TWidget>>
    extends WidgetbookUseCase {
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

  final TArgs args;

  @override
  WidgetbookStory<TWidget, WidgetbookArgs<TWidget>> copyWith({
    String? name,
    List<WidgetbookNode>? children,
  }) {
    return this;
  }
}
