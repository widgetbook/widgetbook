import 'package:meta/meta.dart';

@internal
class AppRouteConfig {
  AppRouteConfig({
    required this.uri,
  });

  static const reservedKeys = {'path', 'preview', 'q'};

  final Uri uri;

  String? get path => uri.queryParameters['path'];

  String? get query => uri.queryParameters['q'];

  bool get previewMode => uri.queryParameters.containsKey('preview');

  /// Returns a modifiable copy of the query parameters without the
  /// keys: `path` and `preview`.
  Map<String, String> get queryParams {
    return Map<String, String>.from(uri.queryParameters)
      ..removeWhere(
        (key, _) => reservedKeys.contains(key),
      );
  }
}
