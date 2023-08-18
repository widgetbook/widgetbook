import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/routing/routing.dart';

void main() {
  group(
    '$AppRouteConfig',
    () {
      test(
        'given a uri, '
        'then query parameters are parsed without reserved keys',
        () {
          final config = AppRouteConfig(
            uri: Uri.parse('/?path=component-x&foo=bar&baz=qux'),
          );

          expect(
            config.queryParams,
            {
              'foo': 'bar',
              'baz': 'qux',
            },
          );
        },
      );

      test(
        'given a uri, '
        'then path is extracted',
        () {
          final config = AppRouteConfig(
            uri: Uri.parse('/?path=component-x&baz=qux'),
          );

          expect(config.path, 'component-x');
        },
      );

      test(
        'given a uri, '
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
