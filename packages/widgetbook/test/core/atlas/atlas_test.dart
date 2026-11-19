import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:widgetbook/src/core/atlas/atlas_flow_graph.dart';
import 'package:widgetbook/src/core/atlas/atlas_layout.dart';
import 'package:widgetbook/src/core/navigation/folder_tree_tile.dart';
import 'package:widgetbook/src/core/state/default_home_page.dart';
import 'package:widgetbook/src/core/widgetbook_app.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/helper.dart';

class _Label extends StatelessWidget {
  const _Label(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Text(text);
}

class _LabelArgs extends StoryArgs<_Label> {
  _LabelArgs(String text) : textArg = $initArg('text', Arg.fixed(text), null)!;

  final Arg<String> textArg;

  @override
  List<Arg?> get list => [textArg];
}

class _LabelStory extends Story<_Label, _LabelArgs> {
  _LabelStory()
    : super(
        name: 'Profile',
        args: _LabelArgs('Default profile'),
        builder: (context, args) => _Label(args.textArg.value),
      );
}

AtlasPage page(Story story) => AtlasPage(story);

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

        expect(flow.pages, [page(login), page(home), page(signUp)]);
        expect(flow.leadsTo(home), isEmpty);
        expect(flow.reachedFrom(home), [page(login)]);
      },
    );

    test(
      'given a story and a page of it without args, '
      'then both refer to the same node',
      () {
        final decorated = AtlasPage(login, decorators: [(_, _, c) => c]);
        final flow = AtlasFlow(
          name: 'Onboarding',
          links: {
            decorated: [home],
            home: [login],
          },
        );

        expect(flow.pages, hasLength(2));
        expect(identical(flow.node(login), decorated), isTrue);
      },
    );

    test(
      'given pages of the same story with different args or ids, '
      'then they are different nodes',
      () {
        final profile = _LabelStory();
        final guest = AtlasPage(profile, args: _LabelArgs('Guest'));
        final member = AtlasPage(profile, args: _LabelArgs('Member'));
        final withId = AtlasPage(profile, id: 'profile');

        final flow = AtlasFlow(
          name: 'Account',
          links: {
            profile: [guest, member, withId, AtlasPage(profile, id: 'profile')],
          },
        );

        expect(flow.pages, hasLength(4));
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
          [page(login)],
          [page(signUp)],
          [page(settings)],
          [page(home)],
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
          [page(login)],
          [page(signUp)],
          [page(home)],
          [page(settings)],
        ]);
        expect(layout.backLinks, {
          (page(signUp), page(login)),
          (page(home), page(home)),
        });
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
          [page(home)],
          [page(settings)],
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
        tester.view.physicalSize = const Size(1600, 2000);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);

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
      'then it is shown as a placeholder',
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

        expect(tester.takeException(), isNull);
        expect(find.text('Not in Config.components'), findsOneWidget);
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

  group('Atlas nodes', () {
    late _LabelStory profile;
    late List<Component> withProfile;

    setUp(() {
      profile = _LabelStory();
      withProfile = [
        ...components,
        Component<_Label, _LabelArgs>(
          name: 'ProfilePage',
          path: 'pages',
          stories: [profile],
        ),
      ];
    });

    Future<WidgetbookState> pumpApp(
      WidgetTester tester,
      Config config,
    ) async {
      tester.view.physicalSize = const Size(1600, 1000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(WidgetbookApp(config: config));
      await tester.pumpAndSettle();

      return WidgetbookState.of(tester.element(find.byType(AtlasHomePage)));
    }

    Finder inAtlasPage(Finder finder) {
      return find.descendant(of: find.byType(AtlasHomePage), matching: finder);
    }

    testWidgets(
      'given a page with args, '
      'then its preview, its opened page and the args panel show those args',
      (tester) async {
        final guest = AtlasPage(
          profile,
          id: 'guest',
          label: 'Profile · guest',
          args: _LabelArgs('Guest profile'),
        );

        final state = await pumpApp(
          tester,
          Config(
            components: withProfile,
            atlas: [
              AtlasFlow(
                name: 'Account',
                links: {
                  home: [guest, profile],
                },
              ),
            ],
          ),
        );

        expect(inAtlasPage(find.text('Guest profile')), findsOneWidget);
        expect(inAtlasPage(find.text('Default profile')), findsOneWidget);

        await tester.findAndTap(inAtlasPage(find.text('Profile · guest')));

        expect(state.path, 'Atlas/Account/guest');
        expect(state.scenario?.args, guest.args);
        expect(find.text('Guest profile'), findsNWidgets(2));
      },
    );

    testWidgets(
      'given no preview config, '
      'then pages show their names only',
      (tester) async {
        await pumpApp(
          tester,
          Config(
            components: withProfile,
            atlasPreview: null,
            atlas: [
              AtlasFlow(
                name: 'Account',
                links: {
                  home: [profile],
                },
              ),
            ],
          ),
        );

        expect(inAtlasPage(find.text('Profile')), findsOneWidget);
        expect(inAtlasPage(find.text('Default profile')), findsNothing);
      },
    );

    testWidgets(
      'given a terminal and decorators, '
      'then the terminal is shown and every node is decorated',
      (tester) async {
        Widget decorate(BuildContext context, AtlasNode node, Widget child) {
          return KeyedSubtree(key: const ValueKey('decorated'), child: child);
        }

        final state = await pumpApp(
          tester,
          Config(
            components: withProfile,
            atlas: [
              AtlasFlow(
                name: 'Account',
                decorators: [decorate],
                links: {
                  home: [
                    const AtlasTerminal(
                      label: 'Log out',
                      description: 'Signs the user out',
                    ),
                  ],
                },
              ),
            ],
          ),
        );

        expect(find.byKey(const ValueKey('decorated')), findsNWidgets(2));

        await tester.findAndTap(inAtlasPage(find.text('Log out')));

        expect(state.path, isNull);
      },
    );

    testWidgets(
      'given a selected viewport, '
      'then previews are rendered at its size',
      (tester) async {
        final viewport = ViewportAddon([IosViewports.iPhone13]);
        final state = WidgetbookState(
          config: Config(components: withProfile, addons: [viewport]),
        );

        expect(
          atlasPreviewSize(state),
          Size(
            IosViewports.iPhone13.maxWidth,
            IosViewports.iPhone13.maxHeight,
          ),
        );
        expect(
          atlasPreviewSize(WidgetbookState()),
          const AtlasPreviewConfig().fallbackSize,
        );
      },
    );

    testWidgets(
      'when tapping zoom in, '
      'then the graph is scaled up',
      (tester) async {
        await pumpApp(
          tester,
          Config(
            components: withProfile,
            atlas: [
              AtlasFlow(
                name: 'Account',
                links: {
                  home: [profile],
                },
              ),
            ],
          ),
        );

        double scale() => tester
            .widget<InteractiveViewer>(find.byType(InteractiveViewer))
            .transformationController!
            .value
            .getMaxScaleOnAxis();

        final before = scale();
        await tester.findAndTap(find.byTooltip('Zoom in'));

        expect(scale(), greaterThan(before));
      },
    );
  });
}
