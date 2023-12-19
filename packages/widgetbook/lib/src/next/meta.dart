import 'args/story_args.dart';

class Meta<T> {
  const Meta({
    String? name,
    this.path,
  }) : name = name ?? '$T';

  final String name;
  final String? path;
}

/// Same as [Meta] but for custom [StoryArgs].
class MetaWithArgs<TWidget, TArgs> extends Meta<TWidget> {
  const MetaWithArgs({
    super.name,
    super.path,
  });
}
