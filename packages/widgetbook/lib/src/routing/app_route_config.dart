class AppRouteConfig {
  AppRouteConfig({
    required this.location,
  }) : queryParameters = Uri.parse(location).queryParameters;

  final String location;
  final Map<String, String> queryParameters;

  String get path => queryParameters['path'] ?? '';

  bool get previewMode => queryParameters.containsKey('preview');
}
