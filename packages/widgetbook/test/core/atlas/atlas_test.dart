import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/core/atlas/atlas_layout.dart';
import 'package:widgetbook/src/core/state/default_home_page.dart';
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
      'given pages leading to each other, '
      'then columns follow the shortest distance from the entry page',
      () {
        final layout = AtlasLayout(
          AtlasFlow(
            name: 'Onboarding',
            links: {
              login: [signUp, home],
              signUp: [home, login],
              home: [settings],
            },
          ),
        );

        expect(layout.columns, [
          [login],
          [signUp, home],
          [settings],
        ]);
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
}
