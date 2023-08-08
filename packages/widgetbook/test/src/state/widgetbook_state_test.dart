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
            appBuilder: materialAppBuilder,
            directories: [],
            queryParams: {paramKey: 'bar'},
          );

          final newValue = 'qux';
          state.updateQueryParam(paramKey, 'qux');

          expect(state.queryParams[paramKey], newValue);
        },
      );

      test(
        'given a state, '
        'when the path is updated, '
        'then the knobs are cleared and removed from query params',
        () {
          final state = WidgetbookState(
            appBuilder: materialAppBuilder,
            directories: [],
            queryParams: {'knobs': '{any_knob:any_value}'},
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
            appBuilder: materialAppBuilder,
            directories: [],
            queryParams: {'knobs': '{${knob.label}:${knob.value}}'},
          );

          final result = state.registerKnob(knob);

          expect(result, knob.value);
        },
      );

      test(
        'given a knob with a value, '
        'when the knob is update to be null, '
        'then the knob value is null when retrieved',
        () {
          final knob = StringKnob(
            label: 'Knob',
            value: 'Widgetbook',
          );

          final state = WidgetbookState(
            appBuilder: materialAppBuilder,
            directories: [],
            queryParams: {'knobs': '{${knob.label}:${knob.value}}'},
          );

          state
            ..registerKnob(knob)
            ..updateKnobNullability(knob.label, true);

          final result = state.registerKnob(knob);

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
            appBuilder: materialAppBuilder,
            directories: [],
            queryParams: {
              'knobs': '{${knob.label}:${knob.value}}',
            },
          );

          const newValue = 'Book of Widgets';
          state
            ..registerKnob(knob)
            ..updateKnobValue(knob.label, newValue);

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
            appBuilder: materialAppBuilder,
            directories: [],
            queryParams: {},
          );

          const path = 'component/use-case';
          final routeConfig = AppRouteConfig(
            location: '/?path=$path&foo=bar&preview',
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
