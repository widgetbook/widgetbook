import 'package:meta/meta.dart';

@internal
class AppRouteConfig {
  AppRouteConfig({
    required this.uri,
  });

  static const reservedKeys = {'path', 'preview', 'q', 'panels'};

  final Uri uri;

  String? get path => uri.queryParameters['path'];

  String? get query => uri.queryParameters['q'];

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
