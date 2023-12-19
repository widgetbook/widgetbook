import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:widgetbook/src/layout/responsive_layout.dart';
import 'package:widgetbook/src/routing/routing.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/helper.dart';

void main() {
  group(
    '$AppRouterDelegate',
    () {
      test(
        'given an initial route, '
        'then the current configuration has the exact location',
        () {
          const initialLocation = '/?path=use-case';

          final delegate = AppRouterDelegate(
            initialRoute: initialLocation,
            state: MockWidgetbookState(),
          );

          expect(
            delegate.currentConfiguration!.uri.toString(),
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
            uri: Uri.parse('/?path=use-case'),
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
          final state = WidgetbookState(
            appBuilder: materialAppBuilder,
            v3Root: WidgetbookRoot(
              children: [],
            ),
          );

          final delegate = AppRouterDelegate(
            initialRoute: '/?preview',
            state: state,
          );

          await tester.pumpWidgetWithState(
            state: state,
            builder: (_) => MaterialApp.router(
              routerDelegate: delegate,
            ),
          );

          expect(
            find.byType(ResponsiveLayout),
            findsNothing,
          );
        },
      );
    },
  );
}
