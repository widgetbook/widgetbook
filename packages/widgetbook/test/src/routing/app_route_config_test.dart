import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/routing/routing.dart';

void main() {
  group(
    '$AppRouteConfig',
    () {
      test(
        'given a location, '
        'then query parameters are parsed',
        () {
          final config = AppRouteConfig(
            uri: Uri.parse('/?foo=bar&baz=qux'),
          );

          expect(
            config.uri.queryParameters,
            {
              'foo': 'bar',
              'baz': 'qux',
            },
          );
        },
      );

      test(
        'given a location, '
        'then path is extracted',
        () {
          final config = AppRouteConfig(
            uri: Uri.parse('/?path=component-x&baz=qux'),
          );

          expect(config.path, 'component-x');
        },
      );

      test(
        'given a location, '
        'then preview mode is extracted',
        () {
          final config = AppRouteConfig(
            uri: Uri.parse('/?path=component-x&preview'),
          );

          expect(config.previewMode, true);
        },
      );
    },
  );
}
