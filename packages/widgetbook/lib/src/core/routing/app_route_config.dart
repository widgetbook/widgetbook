import 'package:meta/meta.dart';

import 'query_group.dart';

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

  /// Example: `panels=navigation,addons,args`
  Set<String>? get panels {
    return uri.queryParameters['panels']?.split(',').toSet();
  }

  Map<String, QueryGroup> get queryGroups {
    return Map<String, QueryGroup>.fromEntries(
      uri.queryParameters.entries
          .where((entry) => QueryGroup.pattern.hasMatch(entry.value))
          .map(
            (entry) => MapEntry(
              entry.key,
              QueryGroup.fromParam(entry.value),
            ),
          ),
    );
  }
}
