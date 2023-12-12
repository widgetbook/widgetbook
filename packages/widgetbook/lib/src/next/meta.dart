import 'args/story_args.dart';

class Meta<T> {
  const Meta({
    String? name,
  }) : name = name ?? '${T}';

  final String name;
}

/// Same as [Meta] but for custom [StoryArgs].
class MetaWithArgs<TWidget, TArgs> extends Meta<TWidget> {
  const MetaWithArgs({super.name});
}
