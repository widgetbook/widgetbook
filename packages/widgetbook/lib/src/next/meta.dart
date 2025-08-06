// next version of Widgetbook doesn't have api docs yet
// ignore_for_file: public_member_api_docs

import 'args/story_args.dart';

class Meta<T> {
  const Meta({
    String? name,
  }) : name = name ?? '$T';

  final String name;
}

/// Same as [Meta] but for custom [StoryArgs].
class MetaWithArgs<TWidget, TArgs> extends Meta<TWidget> {
  const MetaWithArgs({super.name});
}
