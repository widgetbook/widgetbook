import 'package:meta/meta.dart';

@internal
class AppRouteConfig {
  AppRouteConfig({
    required this.uri,
  });

  final Uri uri;

  String? get path => uri.queryParameters['path'];

  bool get previewMode => uri.queryParameters.containsKey('preview');
}
