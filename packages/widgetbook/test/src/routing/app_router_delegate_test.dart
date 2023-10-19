import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
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
            root: WidgetbookRoot(
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
            find.byType(WidgetbookShell),
            findsNothing,
          );
        },
      );

      testWidgets(
        'given a config without preview mode, '
        'then MainApp is shown',
        (tester) async {
          final state = WidgetbookState(
            appBuilder: materialAppBuilder,
            root: WidgetbookRoot(
              children: [],
            ),
          );

          final delegate = AppRouterDelegate(
            state: state,
          );

          await tester.pumpWidgetWithState(
            state: state,
            builder: (_) => MaterialApp.router(
              routerDelegate: delegate,
            ),
          );

          expect(
            find.byType(MainApp),
            findsOneWidget,
          );
        },
      );
    },
  );

  testWidgets(
    'given MainApp, '
    'when left panel button is tapped, '
    'then showLeftPanel is toggled',
    (tester) async {
      final state = WidgetbookState(
        appBuilder: materialAppBuilder,
        root: WidgetbookRoot(
          children: [],
        ),
      );

      await tester.pumpWidgetWithState(
        state: state,
        builder: (_) => const MaterialApp(
          home: MainApp(),
        ),
      );

      // Initial state is true
      expect(find.byType(WidgetbookShell), findsOneWidget);
      var mainAppState = tester.state(find.byType(MainApp)) as MainAppState;
      expect(mainAppState.showLeftPanel, isTrue);

      // Tap the button to toggle showLeftPanel
      await tester.tap(find.byIcon(Icons.menu).first);
      await tester.pumpAndSettle();

      // Check that showLeftPanel is now false
      expect(mainAppState.showLeftPanel, isFalse);
    },
  );

  testWidgets(
    'given MainApp, '
    'when right panel button is tapped, '
    'then showRightPanel is toggled',
    (tester) async {
      final state = WidgetbookState(
        appBuilder: materialAppBuilder,
        root: WidgetbookRoot(
          children: [],
        ),
      );

      await tester.pumpWidgetWithState(
        state: state,
        builder: (_) => const MaterialApp(
          home: MainApp(),
        ),
      );

      // Initial state is true
      expect(find.byType(WidgetbookShell), findsOneWidget);
      var mainAppState = tester.state(find.byType(MainApp)) as MainAppState;
      expect(mainAppState.showRightPanel, isTrue);

      // Tap the button to toggle showRightPanel
      await tester.tap(find.byIcon(Icons.menu).last);
      await tester.pumpAndSettle();

      // Check that showRightPanel is now false
      expect(mainAppState.showRightPanel, isFalse);
    },
  );
}
