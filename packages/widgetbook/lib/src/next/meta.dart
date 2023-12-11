import 'package:flutter/material.dart';

import 'args/story_args.dart';

class Meta<T> {
  const Meta({
    String? name,
  }) : name = name ?? '${T}';

  final String name;
}

typedef ArgsBuilder<TWidget> = TWidget Function(
  BuildContext context,
  StoryArgs<TWidget> args,
);

/// Same as [Meta] but for custom [StoryArgs].
class MetaWithArgs<TWidget, TArgs> extends Meta<TWidget> {
  const MetaWithArgs({
    super.name,
    required this.argsBuilder,
  });

  final ArgsBuilder<TWidget> argsBuilder;
}
