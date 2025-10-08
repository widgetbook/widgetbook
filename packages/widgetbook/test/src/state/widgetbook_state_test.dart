import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:widgetbook/src/routing/routing.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group(
    '$WidgetbookState',
    () {
      test(
        'given a state, '
        'when [updateQueryParam] is called, '
        'then the [queryParams] is updated',
        () {
          final paramKey = 'foo';
          final state = WidgetbookState(
            queryParams: {paramKey: 'bar'},
          );

          final newValue = 'qux';
          state.updateQueryParam(paramKey, 'qux');

          expect(state.queryParams[paramKey], newValue);
        },
      );

      test(
        'given a state, '
        'when [updateQueryField] is called, '
        'then only the field within the group is updated',
        () {
          final state = WidgetbookState(
            queryParams: {
              'knobs': '{foo:bar,qux:baz}',
            },
          );

          state.updateQueryField(
            group: 'knobs',
            field: 'qux',
            value: 'widgetbook',
          );

          expect(
            state.queryParams['knobs'],
            '{foo:bar,qux:widgetbook}',
          );
        },
      );

      test(
        'given a state, '
        'when [updateQueryField] is called with a reserved key, '
        'then an $ArgumentError exception is thrown',
        () {
          final state = WidgetbookState(
            queryParams: {},
          );

          final reservedKey = AppRouteConfig.reservedKeys.first;

          expect(
            () => state.updateQueryParam(reservedKey, '*'),
            throwsArgumentError,
          );
        },
      );

      test(
        'given a state, '
        'then the Uri has path as the first query parameter',
        () {
          final state = WidgetbookState(
            path: 'component/use-case',
            queryParams: {'foo': 'bar'},
          );

          expect(
            state.uri.toString(),
            '/?path=component%2Fuse-case&foo=bar',
          );
        },
      );

      test(
        'given a state, '
        'when the path is updated, '
        'then the args are removed from query params',
        () {
          final args = [const IntArg(1, name: 'number')];
          final previousStoryArgs = MockStoryArgs();
          when(() => previousStoryArgs.safeList).thenReturn(args);

          final previousStory = MockStory();
          when(() => previousStory.name).thenReturn('previous');
          when(() => previousStory.args).thenReturn(previousStoryArgs);

          final nextStory = MockStory();
          when(() => nextStory.name).thenReturn('next');

          final state = WidgetbookState(
            path: 'component/previous',
            queryParams: {for (final arg in args) arg.groupName: '{}'},
            components: [
              Component(
                name: 'component',
                stories: [previousStory, nextStory],
              ),
            ],
          );

          state.updatePath('component/next');

          for (final arg in args) {
            expect(state.queryParams.containsKey(arg.groupName), isFalse);
          }
        },
      );

      test(
        'given a state, '
        'when [updateFromRouteConfig] is called, '
        'then the state is updated',
        () {
          final state = WidgetbookState(
            queryParams: {},
          );

          const path = 'component/use-case';
          const query = 'something';
          final routeConfig = AppRouteConfig(
            uri: Uri.parse('/?path=$path&q=$query&foo=bar&preview'),
          );

          state.updateFromRouteConfig(routeConfig);

          expect(state.path, path);
          expect(state.query, query);
          expect(state.previewMode, true);
          expect(state.queryParams, equals({'foo': 'bar'}));
        },
      );

      test(
        'given a state, '
        'when the search is set to empty string, '
        'search query param is removed',
        () {
          final state = WidgetbookState()..updateQuery('');

          expect(state.queryParams, <String, String>{});
        },
      );
    },
  );
}
