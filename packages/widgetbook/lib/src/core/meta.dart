import 'package:flutter/widgets.dart';

import 'story_args.dart';

class Meta<TWidget extends Widget> {
  const Meta({
    String? name,
    String? path,
    this.docs,
  }) : $name = name,
       $path = path;

  final String? $name;
  final String? $path;
  final String? docs;

  String get name => $name!;
  String? get path => $path;

  /// Creates a copy of this using the provided [path] for late initialization.
  /// If [$name] was already set, it should have precedence over [name].
  /// If [$path] was already set, it should have precedence over [path].
  Meta<TWidget> init({
    required String name,
    required String path,
  }) {
    return Meta<TWidget>(
      name: $name ?? name,
      path: $path ?? path,
      docs: docs,
    );
  }
}

/// Same as [Meta] but for custom [StoryArgs].
class MetaWithArgs<TWidget extends Widget, TArgs> extends Meta<TWidget> {
  const MetaWithArgs({
    super.name,
    super.path,
    super.docs,
  });
}
