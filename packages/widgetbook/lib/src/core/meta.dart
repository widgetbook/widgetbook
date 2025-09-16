import 'story_args.dart';

class Meta<T> {
  const Meta({
    String? name,
    String? path,
  }) : $name = name,
       $path = path;

  final String? $name;
  final String? $path;

  String get name => $name!;
  String? get path => $path;

  /// Creates a copy of this using the provided [path] for late initialization.
  /// If [$name] was already set, it should have precedence over [name].
  /// If [$path] was already set, it should have precedence over [path].
  Meta<T> init({
    required String name,
    required String path,
  }) {
    return Meta<T>(
      name: $name ?? name,
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
