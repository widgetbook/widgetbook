import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/core/routing/routing.dart';
import 'package:widgetbook/src/core/state/state.dart';
import 'package:widgetbook/src/core/theme/theme.dart';
import 'package:widgetbook/src/core/workbench/workbench.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/helper.dart';

// Regression for https://github.com/widgetbook/widgetbook/issues/1984, which
// stayed reproducible after #1994: `Story.defaultSetup` keyed the use case
// subtree by `QueryGroup.hashCode`, which hashed `MapEntry`s by identity and so
// returned a new value on every call. Any story with a non-const arg therefore
// got a fresh key on every rebuild, and the preview was torn down and rebuilt
// from scratch, losing all state a `StatefulWidget` had built up.

/// Only [State] that outlives a rebuild exposes the bug; a stateless use case
/// renders the same either way.
class _Screen extends StatefulWidget {
  const _Screen({required this.phase, required this.title});

  final String phase;
  final String title;

  @override
  State<_Screen> createState() => _ScreenState();
}

class _ScreenState extends State<_Screen> {
  static int mounts = 0;

  @override
  void initState() {
    super.initState();
    mounts++;
  }

  @override
  Widget build(BuildContext context) => Text('${widget.phase}|${widget.title}');
}

/// Mirrors a generated story: a fixed arg carrying the story's identity plus a
/// knob the user can change.
class _Args extends StoryArgs<_Screen> {
  _Args(String phase)
    : phaseArg = Arg.fixed(phase),
      titleArg = StringArg('title', name: 'title');

  final ConstArg<String> phaseArg;
  final StringArg titleArg;

  String get phase => phaseArg.value;
  String get title => titleArg.value;

  @override
  List<Arg?> get list => [phaseArg, titleArg];
}

class _Story extends Story<_Screen, _Args> {
  _Story({required String name, required String phase})
    : super(
        name: name,
        args: _Args(phase),
        builder: (context, args) =>
            _Screen(phase: args.phase, title: args.title),
      );
}

void main() {
  late List<_Story> stories;
  late WidgetbookState state;

  setUp(() {
    _ScreenState.mounts = 0;

    stories = [
      _Story(name: 'Brewing', phase: 'brewing'),
      _Story(name: 'Diluting', phase: 'diluting'),
      _Story(name: 'BrewingFinished', phase: 'brewingFinished'),
    ];

    state = WidgetbookState(
      config: Config(
        components: [
          Component<_Screen, _Args>(
            path: 'brewer_ui',
            name: 'BrewingScreen',
            stories: stories,
          ),
        ],
      ),
    );
  });

  Future<void> pumpWorkbench(WidgetTester tester) async {
    await tester.pumpWidgetWithState(
      state: state,
      builder: (_) => const Workbench(),
    );
  }

  group(
    'A story with a non-const arg',
    () {
      testWidgets(
        'when the state notifies without the story or its args changing, '
        'then the use case keeps its state instead of remounting',
        (tester) async {
          await pumpWorkbench(tester);

          state.updatePath(stories.first.path);
          await tester.pumpAndSettle();
          expect(find.text('brewing|title'), findsOneWidget);

          final mountsAfterSelect = _ScreenState.mounts;

          state.notifyListeners();
          await tester.pumpAndSettle();
          state.notifyListeners();
          await tester.pumpAndSettle();

          expect(_ScreenState.mounts, equals(mountsAfterSelect));
        },
      );

      testWidgets(
        'when a knob value changes, '
        'then the use case is rebuilt with the new value',
        (tester) async {
          await pumpWorkbench(tester);

          state.updatePath(stories.first.path);
          await tester.pumpAndSettle();

          state.updateQueryGroup(
            'title',
            const QueryGroup({'value': 'changed'}),
          );
          await tester.pumpAndSettle();

          expect(find.text('brewing|changed'), findsOneWidget);
        },
      );

      testWidgets(
        'given the full router stack, '
        'when navigating between stories of the same component, '
        'then the preview shows the newly selected story',
        (tester) async {
          final router = AppRouter(state: state, uri: Uri.parse('/'));

          await tester.pumpWidget(
            WidgetbookTheme(
              data: Themes.dark,
              child: WidgetbookScope(
                state: state,
                child: MaterialApp.router(
                  debugShowCheckedModeBanner: false,
                  routerConfig: router,
                ),
              ),
            ),
          );

          for (final story in stories) {
            state.updatePath(story.path);
            await tester.pumpAndSettle();

            expect(
              find.text('${story.args.phase}|title'),
              findsOneWidget,
              reason: 'after selecting ${story.name}',
            );
          }
        },
      );
    },
  );
}
