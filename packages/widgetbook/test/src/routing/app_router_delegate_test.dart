import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:widgetbook/src/routing/routing.dart';
import 'package:widgetbook/src/state/state.dart';

import '../../helper/helper.dart';

void main() {
  group(
    '$AppRouterDelegate',
    () {
      test(
        'given an initial route, '
        'then the current configuration has the exact location',
        () {
          const initialLocation = '/path=use-case';

          final delegate = AppRouterDelegate(
            initialRoute: initialLocation,
            state: MockWidgetbookState(),
          );

          expect(
            delegate.currentConfiguration!.location,
            initialLocation,
          );
        },
      );

      test(
        'given a state, '
        'when a new route is pushed '
        'then the state is updated',
        () {
          final state = MockWidgetbookState();
          final config = AppRouteConfig(
            location: '/path=use-case',
          );

          final delegate = AppRouterDelegate(
            state: state,
          );

          delegate.setNewRoutePath(config);

          verify(
            () => state.updateFromRouteConfig(config),
          ).called(1);
        },
      );

      testWidgets(
        'given a config with preview mode, '
        'then shell is hidden',
        (tester) async {
          final state = MockWidgetbookState();
          when(() => state.uri).thenReturn(Uri());
          when(() => state.appBuilder).thenReturn(materialAppBuilder);

          final delegate = AppRouterDelegate(
            initialRoute: '/?preview',
            state: state,
          );

          await tester.pumpWidget(
            WidgetbookScope(
              state: state,
              child: MaterialApp.router(
                routerDelegate: delegate,
              ),
            ),
          );

          expect(
            find.byType(WidgetbookShell),
            findsNothing,
          );
        },
      );
    },
  );
}
