import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/core/routing/routing.dart';
import 'package:widgetbook/src/core/state/state.dart';
import 'package:widgetbook/src/core/theme/theme.dart';
import 'package:widgetbook/src/core/workbench/workbench.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/helper.dart';

// Regression for https://github.com/widgetbook/widgetbook/issues/1984: the
// preview stayed stuck on the previous story when switching between two stories
// of the same component, and only updated after visiting a story under another
// path and coming back.
//
// `Story.defaultSetup` used to key the use case subtree by the story's args
// alone, so two sibling stories that build the same widget with equal args
// (e.g. all args are `Arg.fixed`, which `safeList` drops) shared a key. Flutter
// then reused the element, and the use case kept the `State` of the previously
// selected story.
//
// Sibling stories were the remaining case after
// https://github.com/widgetbook/widgetbook/pull/1948, which fixed the preview
// getting pinned inside the `Viewport`'s nested `Navigator` for every story.

/// A screen that reads its input in `initState`, like screens that set up
/// controllers or animations once for the state they were built with.
class _Screen extends StatefulWidget {
  const _Screen({required this.status});

  final String status;

  @override
  State<_Screen> createState() => _ScreenState();
}

class _ScreenState extends State<_Screen> {
  late final String _status = widget.status;

  @override
  Widget build(BuildContext context) => Text(_status);
}

class _ScreenArgs extends StoryArgs<_Screen> {
  _ScreenArgs(String status) : statusArg = Arg.fixed(status);

  final ConstArg<String> statusArg;

  String get status => statusArg.value;

  @override
  List<Arg?> get list => [statusArg];
}

class _ScreenStory extends Story<_Screen, _ScreenArgs> {
  _ScreenStory({required String name})
    : super(
        name: name,
        args: _ScreenArgs(name),
        builder: (context, args) => _Screen(status: args.status),
      );
}

class _NoArgs extends StoryArgs<Widget> {
  const _NoArgs();

  @override
  List<Arg?> get list => const [];
}

class _OtherStory extends Story<Widget, _NoArgs> {
  _OtherStory({required super.name})
    : super(
        args: const _NoArgs(),
        builder: (context, args) => const Text('Cleaning'),
      );
}

void main() {
  late _ScreenStory brewing;
  late _ScreenStory flushing;
  late _OtherStory cleaning;
  late WidgetbookState state;

  setUp(() {
    brewing = _ScreenStory(name: 'Brewing');
    flushing = _ScreenStory(name: 'Flushing');
    cleaning = _OtherStory(name: 'Default');

    // Building the components wires up `story.component`,
    // so that `story.path` resolves below.
    final brewingScreen = Component<_Screen, _ScreenArgs>(
      path: 'brewing',
      name: 'BrewingScreen',
      stories: [brewing, flushing],
    );

    final cleaningScreen = Component<Widget, _NoArgs>(
      path: 'cleaning',
      name: 'CleaningScreen',
      stories: [cleaning],
    );

    state = WidgetbookState(
      path: brewing.path,
      config: Config(
        home: const Placeholder(),
        components: [brewingScreen, cleaningScreen],
      ),
    );
  });

  group(
    'Navigating between stories of the same component',
    () {
      testWidgets(
        'when `updatePath` switches to a sibling story, '
        'then the preview shows the newly selected story',
        (tester) async {
          await tester.pumpWidgetWithState(
            state: state,
            builder: (_) => const Workbench(),
          );
          await tester.pumpAndSettle();

          expect(find.text('Brewing'), findsOneWidget);

          state.updatePath(flushing.path);
          await tester.pumpAndSettle();

          expect(find.text('Flushing'), findsOneWidget);
          expect(find.text('Brewing'), findsNothing);
        },
      );

      // Pumped through the full production stack: `MaterialApp.router` ->
      // `AppRouterDelegate` -> `ResponsiveLayout` -> `Workbench`.
      testWidgets(
        'given the full router stack, '
        'when navigating to a sibling story, '
        'then the workbench preview reflects the new story',
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

          state.updatePath(brewing.path);
          await tester.pumpAndSettle();
          expect(find.text('Brewing'), findsOneWidget);

          state.updatePath(flushing.path);
          await tester.pumpAndSettle();

          expect(find.text('Flushing'), findsOneWidget);
          expect(find.text('Brewing'), findsNothing);
        },
      );

      // The detour reported as a workaround in the issue, which kept working
      // while the direct switch was broken.
      testWidgets(
        'when navigating to a story under another path and back, '
        'then the preview shows the newly selected story',
        (tester) async {
          await tester.pumpWidgetWithState(
            state: state,
            builder: (_) => const Workbench(),
          );
          await tester.pumpAndSettle();

          expect(find.text('Brewing'), findsOneWidget);

          state.updatePath(cleaning.path);
          await tester.pumpAndSettle();
          expect(find.text('Cleaning'), findsOneWidget);

          state.updatePath(flushing.path);
          await tester.pumpAndSettle();

          expect(find.text('Flushing'), findsOneWidget);
          expect(find.text('Brewing'), findsNothing);
        },
      );
    },
  );
}
