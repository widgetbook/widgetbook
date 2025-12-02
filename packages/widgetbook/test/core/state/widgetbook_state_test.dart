import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:widgetbook/src/core/routing/routing.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() {
    registerFallbackValue(MockConfig());
  });

  group(
    '$WidgetbookState',
    () {
      test(
        'given a state, '
        'when [updateQueryField] is called, '
        'then only the field within the group is updated',
        () {
          final state = WidgetbookState(
            queryGroups: {
              'foo': const QueryGroup({'bar': 'x'}),
              'baz': const QueryGroup({'qux': 'y'}),
            },
          );

          state.updateQueryField(
            groupName: 'foo',
            fieldName: 'bar',
            fieldValue: 'widgetbook',
          );

          expect(
            state.queryGroups['foo'],
            const QueryGroup({'bar': 'widgetbook'}),
          );
        },
      );

      test(
        'given a state, '
        'then the Uri has path as the first query parameter',
        () {
          final state = WidgetbookState(
            path: 'component/use-case',
            queryGroups: {
              'foo': const QueryGroup({'bar': 'x'}),
            },
          );

          expect(
            state.uri.toString(),
            startsWith('/?path='),
          );
        },
      );

      test(
        'given a state, '
        'when the path is updated, '
        'then the args are removed from query params',
        () {
          final args = [IntArg(1, name: 'number')];
          final previousStoryArgs = MockStoryArgs();
          when(() => previousStoryArgs.safeList).thenReturn(args);

          final previousStory = MockStory();
          when(() => previousStory.name).thenReturn('previous');
          when(() => previousStory.path).thenReturn('component/previous');
          when(() => previousStory.args).thenReturn(previousStoryArgs);
          when(() => previousStory.allScenarios(any())).thenReturn([]);

          final nextStory = MockStory();
          when(() => nextStory.name).thenReturn('next');
          when(() => nextStory.path).thenReturn('component/next');
          when(() => nextStory.allScenarios(any())).thenReturn([]);

          final state = WidgetbookState(
            path: 'component/previous',
            queryGroups: {
              for (final arg in args)
                arg.groupName: const QueryGroup({'foo': '1'}),
            },
            config: Config(
              components: [
                Component(
                  name: 'component',
                  stories: [previousStory, nextStory],
                ),
              ],
            ),
          );

          state.updatePath('component/next');

          for (final arg in args) {
            expect(state.queryGroups.containsKey(arg.groupName), isFalse);
          }
        },
      );

      test(
        'given a state, '
        'when [updateFromRouteConfig] is called, '
        'then the state is updated',
        () {
          final state = WidgetbookState();

          const path = 'component/use-case';
          const query = 'something';
          final routeConfig = AppRouteConfig(
            uri: Uri.parse('/?path=$path&q=$query&foo={bar:x}&preview'),
          );

          state.updateFromRouteConfig(routeConfig);

          expect(state.path, path);
          expect(state.query, query);
          expect(state.previewMode, true);
          expect(
            state.queryGroups,
            equals({
              'foo': const QueryGroup({'bar': 'x'}),
            }),
          );
        },
      );

      test(
        'given a state, '
        'when the search is set to empty string, '
        'search query param is removed',
        () {
          final state = WidgetbookState()..updateQuery('');

          expect(state.uri.queryParameters, isNot(contains('q')));
        },
      );
    },
  );
}
