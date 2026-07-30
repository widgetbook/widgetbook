import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/core/routing/routing.dart';
import 'package:widgetbook/src/core/state/state.dart';
import 'package:widgetbook/src/core/theme/theme.dart';
import 'package:widgetbook/src/core/workbench/workbench.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/helper.dart';

// Regression for https://github.com/widgetbook/widgetbook/issues/1984: two
// stories of the same component shared a `Story.defaultSetup` key when their
// args were equal, so the preview kept the previous story's state.

/// Only [State] that outlives the reused subtree exposes the bug; a stateless
/// use case rebuilds with the new story's values either way.
class _Screen extends StatefulWidget {
  const _Screen({required this.label});

  final String label;

  @override
  State<_Screen> createState() => _ScreenState();
}

class _ScreenState extends State<_Screen> {
  late final String _label = widget.label;

  @override
  Widget build(BuildContext context) => Text(_label);
}

class _Args extends StoryArgs<_Screen> {
  _Args(String label) : labelArg = Arg.fixed(label);

  final ConstArg<String> labelArg;

  String get label => labelArg.value;

  @override
  List<Arg?> get list => [labelArg];
}

class _Story extends Story<_Screen, _Args> {
  _Story({required String name})
    : super(
        name: name,
        args: _Args(name),
        builder: (context, args) => _Screen(label: args.label),
      );
}

class _OtherArgs extends StoryArgs<Widget> {
  const _OtherArgs();

  @override
  List<Arg?> get list => const [];
}

class _OtherStory extends Story<Widget, _OtherArgs> {
  _OtherStory()
    : super(
        name: 'Other',
        args: const _OtherArgs(),
        builder: (context, args) => const Text('Other'),
      );
}

void main() {
  late _Story storyA;
  late _Story storyB;
  late _OtherStory otherStory;
  late WidgetbookState state;

  setUp(() {
    storyA = _Story(name: 'A');
    storyB = _Story(name: 'B');
    otherStory = _OtherStory();

    final component = Component<_Screen, _Args>(
      path: 'components',
      name: 'Component',
      stories: [storyA, storyB],
    );

    final otherComponent = Component<Widget, _OtherArgs>(
      path: 'components',
      name: 'OtherComponent',
      stories: [otherStory],
    );

    state = WidgetbookState(
      path: storyA.path,
      config: Config(
        home: const Placeholder(),
        components: [component, otherComponent],
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

          expect(find.text('A'), findsOneWidget);

          state.updatePath(storyB.path);
          await tester.pumpAndSettle();

          expect(find.text('B'), findsOneWidget);
          expect(find.text('A'), findsNothing);
        },
      );

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

          state.updatePath(storyA.path);
          await tester.pumpAndSettle();
          expect(find.text('A'), findsOneWidget);

          state.updatePath(storyB.path);
          await tester.pumpAndSettle();

          expect(find.text('B'), findsOneWidget);
          expect(find.text('A'), findsNothing);
        },
      );

      testWidgets(
        'when navigating to a story under another component and back, '
        'then the preview shows the newly selected story',
        (tester) async {
          await tester.pumpWidgetWithState(
            state: state,
            builder: (_) => const Workbench(),
          );
          await tester.pumpAndSettle();

          expect(find.text('A'), findsOneWidget);

          state.updatePath(otherStory.path);
          await tester.pumpAndSettle();
          expect(find.text('Other'), findsOneWidget);

          state.updatePath(storyB.path);
          await tester.pumpAndSettle();

          expect(find.text('B'), findsOneWidget);
          expect(find.text('A'), findsNothing);
        },
      );
    },
  );
}
