import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/knobs/string_knob.dart';
import 'package:widgetbook/src/routing/routing.dart';
import 'package:widgetbook/widgetbook.dart';

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
            root: WidgetbookRoot(
              children: [],
            ),
          );

          final newValue = 'qux';
          state.updateQueryParam(paramKey, 'qux');

          expect(state.queryParams[paramKey], newValue);
        },
      );

      test(
        'given a state, '
        'when [updateQueryParam] is called with a reserved key, '
        'then an $ArgumentError exception is thrown',
        () {
          final state = WidgetbookState(
            queryParams: {},
            root: WidgetbookRoot(
              children: [],
            ),
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
            root: WidgetbookRoot(
              children: [],
            ),
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
        'then the knobs are cleared and removed from query params',
        () {
          final state = WidgetbookState(
            queryParams: {'knobs': '{any_knob:any_value}'},
            root: WidgetbookRoot(
              children: [],
            ),
          );

          state.updatePath('component/use-case');

          expect(state.knobs, isEmpty);
          expect(state.queryParams['knobs'], isNull);
        },
      );

      test(
        'given a knob with a value, '
        'when registering the knob, '
        'then the value is returned',
        () {
          final knob = StringKnob(
            label: 'Knob',
            value: 'Widgetbook',
          );

          final state = WidgetbookState(
            queryParams: {'knobs': '{${knob.label}:${knob.value}}'},
            root: WidgetbookRoot(
              children: [],
            ),
          );

          final result = state.knobs.register(
            knob,
            state.queryParams,
          );

          expect(result, knob.value);
        },
      );

      test(
        'given a knob with a value, '
        'when the knob is update to be null, '
        'then the knob value is null when retrieved',
        () {
          final knob = StringKnob.nullable(
            label: 'Knob',
            value: 'Widgetbook',
          );

          final state = WidgetbookState(
            queryParams: {'knobs': '{${knob.label}:${knob.value}}'},
            root: WidgetbookRoot(
              children: [],
            ),
          );

          state.knobs
            ..register(knob, state.queryParams)
            ..updateNullability(knob.label, true);

          final result = state.knobs.register(
            knob,
            state.queryParams,
          );

          expect(result, isNull);
        },
      );

      test(
        'given a knob with a value, '
        'when the knob value is updated, '
        'then the new value is returned',
        () {
          final knob = StringKnob(
            label: 'Knob',
            value: 'Widgetbook',
          );

          final state = WidgetbookState(
            queryParams: {'knobs': '{${knob.label}:${knob.value}}'},
            root: WidgetbookRoot(
              children: [],
            ),
          );

          const newValue = 'Book of Widgets';
          state.knobs
            ..register(knob, state.queryParams)
            ..updateValue(knob.label, newValue);

          final result = state.knobs[knob.label]!.value;

          expect(result, newValue);
        },
      );

      test(
        'given a state, '
        'when [updateFromRouteConfig] is called, '
        'then the state is updated',
        () {
          final state = WidgetbookState(
            queryParams: {},
            root: WidgetbookRoot(
              children: [],
            ),
          );

          const path = 'component/use-case';
          final routeConfig = AppRouteConfig(
            uri: Uri.parse('/?path=$path&foo=bar&preview'),
          );

          state.updateFromRouteConfig(routeConfig);

          expect(state.path, path);
          expect(state.previewMode, true);
          expect(state.queryParams, equals({'foo': 'bar'}));
        },
      );
    },
  );
}
