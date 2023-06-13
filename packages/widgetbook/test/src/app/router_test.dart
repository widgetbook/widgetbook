import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/routing/routing.dart';
import 'package:widgetbook/src/routing/widgetbook_shell.dart';
import 'package:widgetbook/src/state/state.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  final wbThemeLight = WidgetbookTheme(
    name: 'Light',
    data: ThemeData.light(),
  );
  final wbThemeDark = WidgetbookTheme(
    name: 'Dark',
    data: ThemeData.dark(),
  );

  final addons = [
    MaterialThemeAddon(
      themes: [
        wbThemeLight,
        wbThemeDark,
      ],
    ),
  ];

  final directories = [
    WidgetbookComponent(
      name: 'Component 1',
      useCases: [
        WidgetbookUseCase(
          name: 'Use-case 1.1',
          builder: (context) => const Text(
            'Text 1.1',
            key: ValueKey('Text 1.1'),
          ),
        ),
        WidgetbookUseCase(
          name: 'Use-case 1.2',
          builder: (context) => const Text(
            'Text 1.2',
            key: ValueKey('Text 1.2'),
          ),
        ),
      ],
    ),
    WidgetbookComponent(
      name: 'Component 2',
      useCases: [
        WidgetbookUseCase(
          name: 'Use-case 2.1',
          builder: (context) => const Text(
            'Text 2.1',
            key: ValueKey('Text 2.1'),
          ),
        ),
        WidgetbookUseCase(
          name: 'Use-case 2.2',
          builder: (context) => const Text(
            'Text 2.2',
            key: ValueKey('Text 2.2'),
          ),
        ),
      ],
    )
  ];

  final initialState = WidgetbookState(
    addons: addons,
    directories: directories,
    appBuilder: materialAppBuilder,
  );

  Future<void> pumpRouter({
    required WidgetTester tester,
    required AppRouter router,
  }) async {
    await tester.pumpWidget(
      MaterialApp.router(
        routerConfig: router,
      ),
    );
  }

  group(
    'Router',
    () {
      group(
        'loads',
        () {
          testWidgets(
            'default route',
            (tester) async {
              final router = AppRouter(
                initialState: initialState,
              );

              await pumpRouter(
                tester: tester,
                router: router,
              );

              final dropdownFinder = find.byWidgetPredicate(
                (widget) =>
                    widget is DropdownMenu<WidgetbookTheme<ThemeData>> &&
                    widget.initialSelection == wbThemeLight,
              );

              final state = WidgetbookState.of(
                tester.element(
                  find.byType(WidgetbookScope),
                ),
              );

              expect(dropdownFinder, findsOneWidget);
              expect(state.useCase, isNull);
            },
          );

          testWidgets(
            'custom route',
            (tester) async {
              final router = AppRouter(
                initialRoute: '/?path=component-2%2Fuse-case-2.1',
                initialState: initialState,
              );

              await pumpRouter(
                tester: tester,
                router: router,
              );

              final dropdownFinder = find.byWidgetPredicate(
                (widget) =>
                    widget is DropdownMenu<WidgetbookTheme<ThemeData>> &&
                    widget.initialSelection == wbThemeLight,
              );

              final state = WidgetbookState.of(
                tester.element(
                  find.byType(WidgetbookScope),
                ),
              );

              expect(dropdownFinder, findsOneWidget);
              expect(state.useCase, isNotNull);
              expect(state.path, contains('use-case-2.1'));
            },
          );

          testWidgets(
            'theme addon value',
            (tester) async {
              final router = AppRouter(
                initialRoute: '/?theme=Dark',
                initialState: initialState,
              );

              await pumpRouter(
                tester: tester,
                router: router,
              );

              final dropdownFinder = find.byWidgetPredicate(
                (widget) =>
                    widget is DropdownMenu<WidgetbookTheme<ThemeData>> &&
                    widget.initialSelection == wbThemeDark,
              );

              expect(dropdownFinder, findsOneWidget);
            },
            skip: true,
          );

          testWidgets(
            'preview mode',
            (tester) async {
              final router = AppRouter(
                initialRoute: '/?preview',
                initialState: initialState,
              );

              await pumpRouter(
                tester: tester,
                router: router,
              );

              final shellFinder = find.byType(WidgetbookShell);

              expect(shellFinder, findsNothing);
            },
          );
        },
      );
    },
  );
}
