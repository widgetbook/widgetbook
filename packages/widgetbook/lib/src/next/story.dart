// next version of Widgetbook doesn't have api docs yet
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

import '../navigation/nodes/nodes.dart' as v3;
import 'args/story_args.dart';

typedef SetupBuilder<TArgs> = Widget Function(
  BuildContext context,
  Widget story,
  TArgs args,
);

typedef ArgsBuilder<TWidget extends Widget, TArgs extends StoryArgs<TWidget>>
    = TWidget Function(BuildContext context, TArgs args);

@optionalTypeArgs
abstract class Story<TWidget extends Widget, TArgs extends StoryArgs<TWidget>>
    extends v3.WidgetbookUseCase {
  Story({
    required super.name,
    super.designLink,
    this.setup = defaultSetup,
    required this.args,
    required this.argsBuilder,
  }) : super(
          builder: (context) => const SizedBox.shrink(), // TODO: remove
        );

  final TArgs args;
  final SetupBuilder<TArgs> setup;
  final ArgsBuilder<TWidget, TArgs> argsBuilder;

  static Widget defaultSetup(
    BuildContext context,
    Widget story,
    dynamic args,
  ) {
    return story;
  }

  @override
  Widget build(BuildContext context) {
    return buildWithArgs(context, args);
  }

  /// Same as [build], but uses external [args] instead of [Story.args].
  Widget buildWithArgs(BuildContext context, TArgs args) {
    final story = argsBuilder(context, args);
    return setup(context, story, args);
  }

  @override
  Story<TWidget, TArgs> copyWith({
    String? name,
    List<v3.WidgetbookNode>? children,
  }) {
    return this;
  }
}
