import 'package:flutter/widgets.dart';

import '../docs/docs.dart';
import 'story_args.dart';

/// Metadata for generating code for a given [TWidget].
class Meta<TWidget extends Widget> {
  const Meta({
    this.name,
    this.path,
    this.docsBuilder,
    this.constructor,
  });

  final String? name;
  final String? path;
  final DocsBuilderFunction? docsBuilder;

  /// A constructor tear-off that specifies which constructor of [TWidget]
  /// to use for generating [StoryArgs] and the default builder.
  ///
  /// When `null`, the unnamed (default) constructor is used.
  ///
  /// Example:
  /// ```dart
  /// const meta = Meta<Button>(constructor: Button.icon);
  /// ```
  final Function? constructor;
}

/// Same as [Meta] but for custom [StoryArgs].
class MetaWithArgs<TWidget extends Widget, TArgs> extends Meta<TWidget> {
  const MetaWithArgs({
    super.name,
    super.path,
    super.docsBuilder,
    super.constructor,
  });
}
