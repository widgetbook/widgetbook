/// Represents the configuration of the current app route,
/// parsed from a [Uri] containing query parameters.
class AppRouteConfig {
  /// Creates an [AppRouteConfig] from the given [uri].
  const AppRouteConfig({
    required this.uri,
  });

  /// The set of query parameter keys reserved for internal use by Widgetbook.
  static const reservedKeys = {'path', 'preview', 'q', 'panels'};

  /// The [Uri] representing the current route.
  final Uri uri;

  /// The currently selected use-case path, derived from the `path` query parameter.
  String? get path => uri.queryParameters['path'];

  /// The current search query, derived from the `q` query parameter.
  String? get query => uri.queryParameters['q'];

  /// Whether the app is in preview mode, determined by the presence
  /// of the `preview` query parameter.
  bool get previewMode => uri.queryParameters.containsKey('preview');

  /// Example: `panels=navigation,addons,knobs`
  Set<String>? get panels {
    return uri.queryParameters['panels']?.split(',').toSet();
  }

  /// Returns a modifiable copy of the query parameters
  /// without the reserved keys.
  Map<String, String> get queryParams {
    return Map<String, String>.from(uri.queryParameters)..removeWhere(
      (key, _) => reservedKeys.contains(key),
    );
  }
}
