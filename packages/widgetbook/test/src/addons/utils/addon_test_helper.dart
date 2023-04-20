import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:widgetbook_addon/widgetbook_addon.dart';

import 'extensions/widget_tester_extension.dart';

Future<void> testAddon({
  required WidgetTester tester,
  required WidgetbookAddOn addon,
  required void Function(BuildContext context) expect,
  Future<void> Function()? act,
}) async {
  const key = ValueKey('RandomKey');

  final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        name: '/',
        pageBuilder: (context, state) {
          return NoTransitionPage<void>(
            child: Scaffold(
              // Simulates the approximate width of the panel.
              // It's also required to make some tests work
              // (not totally clear why).
              body: SizedBox(
                width: 500,
                child: Builder(
                  builder: (context) {
                    return addon.buildWithScope(
                      state.queryParams,
                      Builder(
                        key: key,
                        builder: addon.buildSetting,
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      )
    ],
  );

  await tester.pumpWidget(
    MaterialApp.router(
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      routerDelegate: router.routerDelegate,
    ),
  );

  await act?.call();
  await tester.pumpAndSettle();

  final context = tester.findContextByKey(key);
  expect(context);
}
