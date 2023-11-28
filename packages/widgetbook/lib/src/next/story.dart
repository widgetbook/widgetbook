import 'package:flutter/material.dart';

import '../fields/fields.dart';
import '../navigation/nodes/nodes.dart' as v3;
import '../state/state.dart';
import 'args/story_args.dart';

@optionalTypeArgs
class Story<TWidget> extends v3.WidgetbookUseCase {
  Story({
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

  final StoryArgs<TWidget> args;

  @override
  Story<TWidget> copyWith({
    String? name,
    List<v3.WidgetbookNode>? children,
  }) {
    return this;
  }
}
