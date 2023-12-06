import 'package:flutter/material.dart';

import '../fields/fields.dart';
import '../navigation/nodes/nodes.dart' as v3;
import '../state/state.dart';
import 'args/story_args.dart';

typedef StoryBuilder = Widget Function(BuildContext context, Widget story);

@optionalTypeArgs
class Story<TWidget> extends v3.WidgetbookUseCase {
  Story({
    required super.name,
    required this.args,
    super.designLink,
    this.setup,
  }) : super(
          builder: (context) {
            final state = WidgetbookState.of(context);
            final groupMap = FieldCodec.decodeQueryGroup(
              state.queryParams['args'],
            );

            final story = args.build(context, groupMap);

            return setup != null ? setup(context, story) : story;
          },
        );

  final StoryArgs<TWidget> args;
  final StoryBuilder? setup;

  @override
  Story<TWidget> copyWith({
    String? name,
    List<v3.WidgetbookNode>? children,
  }) {
    return this;
  }
}
