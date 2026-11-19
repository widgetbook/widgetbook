import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/core/routing/routing.dart';

void main() {
  group(
    '$AppRouteConfig',
    () {
      test(
        'given a uri, '
        'then query parameters are parsed without reserved keys',
        () {
          final config = AppRouteConfig(
            uri: Uri.parse('/?path=component-x&foo={bar:x}&baz={qux:y}'),
          );

          expect(
            config.queryGroups,
            {
              'foo': const QueryGroup({'bar': 'x'}),
              'baz': const QueryGroup({'qux': 'y'}),
            },
          );
        },
      );

      test(
        'given a uri with a malformed query group, '
        'then query groups are parsed without throwing',
        () {
          final config = AppRouteConfig(
            uri: Uri.parse(
              '/?path=component-x&text-scale={value}&foo={bar:x,oops}',
            ),
          );

          expect(
            config.queryGroups,
            {
              'text-scale': QueryGroup.empty,
              'foo': const QueryGroup({'bar': 'x'}),
            },
          );
        },
      );

      test(
        'given a uri with nullified query groups, '
        'then they are parsed with their fields',
        () {
          final config = AppRouteConfig(
            uri: Uri.parse('/?path=component-x&a=??{f:1}&b=??{}&c=??'),
          );

          expect(
            config.queryGroups,
            {
              'a': const QueryGroup({'f': '1'}, isNullified: true),
              'b': QueryGroup.nullified,
              'c': QueryGroup.nullified,
            },
          );
        },
      );

      test(
        'given a uri with a single question mark before a group, '
        'then it is not parsed as a query group',
        () {
          final config = AppRouteConfig(
            uri: Uri.parse('/?path=component-x&a=?{f:1}'),
          );

          expect(config.queryGroups, isEmpty);
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
