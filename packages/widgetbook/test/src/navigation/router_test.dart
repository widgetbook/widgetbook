import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/addons/addon_provider.dart';
import 'package:widgetbook/src/builder/functions/app_builder.dart';
import 'package:widgetbook/src/builder/provider/builder_provider.dart';
import 'package:widgetbook/src/navigation/router.dart';
import 'package:widgetbook/src/repositories/selected_use_case_repository.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

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
      setting: ThemeSetting.firstAsSelected(
        themes: [
          wbThemeLight,
          wbThemeDark,
        ],
      ),
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

  late BuilderProvider builderProvider;
  late SelectedUseCaseRepository selectedStoryRepository;
  late UseCasesProvider useCasesProvider;
  late KnobsNotifier knobsNotifier;
  late NavigationBloc navigationBloc;

  setUp(
    () {
      builderProvider = BuilderProvider(
        appBuilder: materialAppBuilder,
      );
      selectedStoryRepository = SelectedUseCaseRepository();
      useCasesProvider = UseCasesProvider(
        selectedStoryRepository: selectedStoryRepository,
      )..loadFromDirectories(directories);
      knobsNotifier = KnobsNotifier(selectedStoryRepository);
      navigationBloc = NavigationBloc();
    },
  );

  Future<void> pumpRouter({
    required WidgetTester tester,
    required GoRouter router,
  }) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: knobsNotifier),
          ChangeNotifierProvider.value(value: useCasesProvider),
          ChangeNotifierProvider.value(value: builderProvider),
          ChangeNotifierProvider(
            create: (_) => AddOnProvider(addons),
          ),
        ],
        child: BlocProvider(
          create: (context) => navigationBloc
            ..add(
              LoadNavigationTree(directories: directories),
            ),
          child: MaterialApp.router(
            routeInformationProvider: router.routeInformationProvider,
            routeInformationParser: router.routeInformationParser,
            routerDelegate: router.routerDelegate,
          ),
        ),
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
              final router = createRouter(
                useCasesProvider: useCasesProvider,
                initialLocation: '/',
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

              expect(dropdownFinder, findsOneWidget);
              expect(navigationBloc.state.selectedNode, isNull);
            },
          );

          testWidgets(
            'custom route',
            (tester) async {
              final router = createRouter(
                useCasesProvider: useCasesProvider,
                initialLocation: '/?path=component-2%2Fuse-case-2.1',
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

              expect(dropdownFinder, findsOneWidget);
              expect(navigationBloc.state.selectedNode, isNotNull);
              expect(navigationBloc.state.selectedNode!.name, 'Use-case 2.1');
            },
          );

          testWidgets(
            'theme addon value',
            (tester) async {
              final router = createRouter(
                useCasesProvider: useCasesProvider,
                initialLocation: '/?theme=Dark',
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
              expect(navigationBloc.state.selectedNode, isNull);
            },
          );
        },
      );
    },
  );
}
