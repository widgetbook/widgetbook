import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/core/atlas/atlas_layout.dart';
import 'package:widgetbook/src/core/navigation/folder_tree_tile.dart';
import 'package:widgetbook/src/core/state/default_home_page.dart';
import 'package:widgetbook/src/core/widgetbook_app.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/helper.dart';

void main() {
  late TestStory login;
  late TestStory signUp;
  late TestStory home;
  late TestStory settings;
  late List<Component> components;

  setUp(() {
    login = TestStory(name: 'Login');
    signUp = TestStory(name: 'SignUp');
    home = TestStory(name: 'Home');
    settings = TestStory(name: 'Settings');

    components = [
      Component<SizedBox, TestStoryArgs>(
        name: 'AuthPage',
        path: 'pages',
        stories: [login, signUp],
      ),
      Component<SizedBox, TestStoryArgs>(
        name: 'HomePage',
        path: 'pages',
        stories: [home, settings],
      ),
    ];
  });

  group('$AtlasFlow', () {
    test(
      'given a page that is only a target, '
      'then it is part of the pages and reached from its source',
      () {
        final flow = AtlasFlow(
          name: 'Onboarding',
          links: {
            login: [home, signUp],
          },
        );

        expect(flow.pages, [login, home, signUp]);
        expect(flow.leadsTo(home), isEmpty);
        expect(flow.reachedFrom(home), [login]);
      },
    );
  });

  group('$AtlasLayout', () {
    test(
      'given a page reached both directly and through other pages, '
      'then it is placed after the longest path to it',
      () {
        final layout = AtlasLayout(
          AtlasFlow(
            name: 'Onboarding',
            links: {
              login: [home, signUp],
              signUp: [settings],
              settings: [home],
            },
          ),
        );

        expect(layout.columns, [
          [login],
          [signUp],
          [settings],
          [home],
        ]);
      },
    );

    test(
      'given pages leading back to an earlier page, '
      'then only those links are back links',
      () {
        final layout = AtlasLayout(
          AtlasFlow(
            name: 'Onboarding',
            links: {
              login: [signUp, home],
              signUp: [home, login],
              home: [settings, home],
            },
          ),
        );

        expect(layout.columns, [
          [login],
          [signUp],
          [home],
          [settings],
        ]);
        expect(layout.backLinks, {(signUp, login), (home, home)});
      },
    );

    test(
      'given a flow that is a cycle without an entry page, '
      'then the first declared page starts the first column',
      () {
        final layout = AtlasLayout(
          AtlasFlow(
            name: 'Loop',
            links: {
              home: [settings],
              settings: [home],
            },
          ),
        );

        expect(layout.columns, [
          [home],
          [settings],
        ]);
      },
    );
  });

  group('$AtlasHomePage', () {
    WidgetbookState stateWith(List<AtlasFlow> atlas) {
      return WidgetbookState(
        config: Config(components: components, atlas: atlas),
      );
    }

    testWidgets(
      'given an atlas, '
      'when no story is selected, '
      'then the default home page shows each flow',
      (tester) async {
        final state = stateWith([
          AtlasFlow(
            name: 'Onboarding',
            links: {
              login: [home],
            },
          ),
          AtlasFlow(
            name: 'Settings',
            links: {
              home: [settings],
            },
          ),
        ]);

        await tester.pumpWidgetWithState(
          state: state,
          builder: (_) => const DefaultHomePage(),
        );

        expect(find.text('Onboarding'), findsOneWidget);
        expect(find.text('Settings'), findsNWidgets(2));
        expect(find.text('Home'), findsNWidgets(2));
      },
    );

    testWidgets(
      'when a page is tapped, '
      'then its story is selected',
      (tester) async {
        final state = stateWith([
          AtlasFlow(
            name: 'Onboarding',
            links: {
              login: [home],
            },
          ),
        ]);

        await tester.pumpWidgetWithState(
          state: state,
          builder: (_) => const AtlasHomePage(),
        );
        await tester.findAndTap(find.text('Home'));

        expect(state.path, home.path);
      },
    );

    testWidgets(
      'given a flow referencing a story outside of the components, '
      'then a descriptive error is thrown',
      (tester) async {
        final state = stateWith([
          AtlasFlow(
            name: 'Onboarding',
            links: {
              login: [TestStory(name: 'Unregistered')],
            },
          ),
        ]);

        await tester.pumpWidgetWithState(
          state: state,
          builder: (_) => const AtlasHomePage(),
        );

        expect(
          tester.takeException(),
          isA<FlutterError>().having(
            (error) => error.message,
            'message',
            contains('"Onboarding"'),
          ),
        );
      },
    );
  });

  group('$LeadsToDocBlock', () {
    testWidgets(
      'given a story of the component in a flow, '
      'then its links are listed and navigate on tap',
      (tester) async {
        final state = WidgetbookState(
          path: components.first.docsPath,
          config: Config(
            components: components,
            atlas: [
              AtlasFlow(
                name: 'Onboarding',
                links: {
                  login: [home],
                  signUp: [login],
                },
              ),
            ],
          ),
        );

        await tester.pumpWidgetWithState(
          state: state,
          builder: (_) => const LeadsToDocBlock(),
        );

        expect(find.text('Login · Onboarding'), findsOneWidget);
        expect(find.text('SignUp · Onboarding'), findsOneWidget);
        expect(find.text('AuthPage / SignUp'), findsOneWidget);

        await tester.findAndTap(find.text('HomePage / Home'));

        expect(state.path, home.path);
      },
    );

    testWidgets(
      'given no story of the component in a flow, '
      'then nothing is shown',
      (tester) async {
        final state = WidgetbookState(
          path: components.first.docsPath,
          config: Config(
            components: components,
            atlas: [
              AtlasFlow(
                name: 'Settings',
                links: {
                  home: [settings],
                },
              ),
            ],
          ),
        );

        await tester.pumpWidgetWithState(
          state: state,
          builder: (_) => const LeadsToDocBlock(),
        );

        expect(find.text('Leads to'), findsNothing);
      },
    );
  });

  group('Atlas navigation', () {
    late List<AtlasFlow> atlas;

    setUp(() {
      atlas = [
        AtlasFlow(
          name: 'Onboarding',
          links: {
            login: [signUp],
          },
        ),
        AtlasFlow(
          name: 'Preferences',
          links: {
            home: [settings],
          },
        ),
      ];
    });

    Future<WidgetbookState> pumpApp(
      WidgetTester tester,
      List<AtlasFlow> atlas,
    ) async {
      tester.view.physicalSize = const Size(1600, 1000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        WidgetbookApp(
          config: Config(components: components, atlas: atlas),
        ),
      );
      await tester.pumpAndSettle();

      return WidgetbookState.of(tester.element(find.byType(AtlasHomePage)));
    }

    Finder inTree(String text) {
      return find.descendant(
        of: find.byType(FolderTreeTile),
        matching: find.text(text),
      );
    }

    Finder inAtlasPage(String text) {
      return find.descendant(
        of: find.byType(AtlasHomePage),
        matching: find.text(text),
      );
    }

    testWidgets(
      'when tapping a flow in the navigation tree, '
      'then only that flow is shown',
      (tester) async {
        final state = await pumpApp(tester, atlas);

        await tester.findAndTap(inTree('Preferences'));

        expect(state.path, 'Atlas/Preferences');
        expect(inAtlasPage('Preferences'), findsOneWidget);
        expect(inAtlasPage('Settings'), findsOneWidget);
        expect(inAtlasPage('Onboarding'), findsNothing);
        expect(inAtlasPage('SignUp'), findsNothing);
      },
    );

    testWidgets(
      'given a page was opened, '
      'when tapping the atlas node in the navigation tree, '
      'then all flows are shown again',
      (tester) async {
        final state = await pumpApp(tester, atlas);

        await tester.findAndTap(inAtlasPage('SignUp'));
        expect(state.path, signUp.path);
        expect(find.byType(AtlasHomePage), findsNothing);

        await tester.findAndTap(inTree('Atlas'));

        expect(state.path, 'Atlas');
        expect(inAtlasPage('Onboarding'), findsOneWidget);
        expect(inAtlasPage('Preferences'), findsOneWidget);
      },
    );

    testWidgets(
      'when calling goHome, '
      'then the selected story is cleared',
      (tester) async {
        final state = await pumpApp(tester, atlas);

        state.goToStory(home);
        await tester.pumpAndSettle();
        state.goHome();
        await tester.pumpAndSettle();

        expect(state.path, isNull);
        expect(find.byType(AtlasHomePage), findsOneWidget);
      },
    );

    testWidgets(
      'given no atlas, '
      'then the navigation tree has no atlas node',
      (tester) async {
        tester.view.physicalSize = const Size(1600, 1000);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);

        await tester.pumpWidget(
          WidgetbookApp(config: Config(components: components)),
        );
        await tester.pumpAndSettle();

        expect(inTree('Atlas'), findsNothing);
      },
    );
  });
}
