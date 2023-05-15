import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:widgetbook/src/addons/common/common.dart';
import 'package:widgetbook/src/state/state.dart';

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
        builder: (context, state) {
          return WidgetbookScope(
            state: WidgetbookState(
              path: state.queryParams['path'] ?? '',
              panels: state.queryParams['panels'] == null
                  ? WidgetbookPanel.values.toSet()
                  : WidgetbookPanelParser.parse(state.queryParams['panels']!),
              queryParams: {...state.queryParams}, // Copy from UnmodifiableMap
              addons: [addon],
              appBuilder: materialAppBuilder,
              catalogue: WidgetbookCatalogue.fromDirectories([]),
            ),
            child: Scaffold(
              // Simulates the approximate width of the panel.
              // It's also required to make some tests work
              // (not totally clear why).
              body: SizedBox(
                width: 500,
                child: Builder(
                  key: key,
                  builder: (context) {
                    return Column(
                      children: addon.fields
                          .map((field) => field.build(context))
                          .toList(),
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
      routerConfig: router,
    ),
  );

  await act?.call();
  await tester.pumpAndSettle();

  final context = tester.findContextByKey(key);
  expect(context);
}
