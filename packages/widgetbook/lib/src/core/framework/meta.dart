import 'package:flutter/widgets.dart';

import 'story_args.dart';

/// Metadata for generating code for a given [TWidget].
class Meta<TWidget extends Widget> {
  const Meta({
    this.name,
    this.path,
    this.docs,
  });

  final String? name;
  final String? path;
  final String? docs;
}

/// Same as [Meta] but for custom [StoryArgs].
class MetaWithArgs<TWidget extends Widget, TArgs> extends Meta<TWidget> {
  const MetaWithArgs({
    super.name,
    super.path,
    super.docs,
  });
}
