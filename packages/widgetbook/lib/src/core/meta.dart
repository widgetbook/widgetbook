import 'story_args.dart';

class Meta<T> {
  const Meta({
    String? name,
    String? path,
  }) : name = name ?? '$T',
       $path = path;

  final String name;
  final String? $path;

  String? get path => $path;

  /// Creates a copy of this using the provided [path] for late initialization.
  /// If [$path] was already set, it should have precedence over [path].
  Meta<T> init({
    required String path,
  }) {
    final genericRegex = RegExp(r'<.*>');
    return Meta<T>(
      name: name.replaceAll(genericRegex, ''),
      path: $path ?? path,
    );
  }
}

/// Same as [Meta] but for custom [StoryArgs].
class MetaWithArgs<TWidget, TArgs> extends Meta<TWidget> {
  const MetaWithArgs({
    super.name,
    super.path,
  });
}
