import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:widgetbook/src/core/layout/responsive_layout.dart';
import 'package:widgetbook/src/core/routing/routing.dart';
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
          final uri = Uri.parse('/?path=use-case');
          final state = WidgetbookState();

          final delegate = AppRouterDelegate(
            uri: uri,
            state: state,
          );

          expect(
            delegate.currentConfiguration.uri,
            uri,
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
            uri: Uri.parse('/'),
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
          final state = WidgetbookState();

          final delegate = AppRouterDelegate(
            uri: Uri.parse('/?preview'),
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
