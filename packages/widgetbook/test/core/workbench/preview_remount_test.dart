import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/core/workbench/workbench.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/helper.dart';

// Regression for https://github.com/widgetbook/widgetbook/issues/1984.
// The preview must remount when the selected story changes, and must survive
// every rebuild that leaves the story and its args untouched.

/// Captures the story's [label] in `initState`, standing in for a provider
/// whose `create` only runs when it mounts, e.g. `BlocProvider`.
class _Setup extends StatefulWidget {
  const _Setup({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  State<_Setup> createState() => _SetupState();
}

class _SetupState extends State<_Setup> {
  static int mounts = 0;

  late final String _label = widget.label;

  @override
  void initState() {
    super.initState();
    mounts++;
  }

  @override
  Widget build(BuildContext context) {
    return _Label(label: _label, child: widget.child);
  }
}

class _Label extends InheritedWidget {
  const _Label({required this.label, required super.child});

  final String label;

  static String of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_Label>()!.label;
  }

  @override
  bool updateShouldNotify(_Label oldWidget) => label != oldWidget.label;
}

/// Only [State] that outlives a rebuild exposes the bug; a stateless use case
/// renders the same either way.
class _Screen extends StatefulWidget {
  const _Screen({required this.title});

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
  Widget build(BuildContext context) {
    return Text('${_Label.of(context)}|${widget.title}');
  }
}

/// A single non-fixed arg is what used to give the story a fresh key on every
/// rebuild, so it is the minimum needed to reproduce the teardown.
class _Args extends StoryArgs<_Screen> {
  _Args() : titleArg = StringArg('title', name: 'title');

  final StringArg titleArg;

  String get title => titleArg.value;

  @override
  List<Arg?> get list => [titleArg];
}

class _Story extends Story<_Screen, _Args> {
  _Story({required String name, required String label})
    : super(
        name: name,
        args: _Args(),
        setup: (context, widget, args) => _Setup(
          label: label,
          child: Story.defaultSetup(context, widget, args),
        ),
        builder: (context, args) => _Screen(title: args.title),
      );
}

void main() {
  late _Story storyA;
  late _Story storyB;
  late WidgetbookState state;

  setUp(() {
    _SetupState.mounts = 0;
    _ScreenState.mounts = 0;

    storyA = _Story(name: 'A', label: 'alpha');
    storyB = _Story(name: 'B', label: 'beta');

    state = WidgetbookState(
      queryGroups: {},
      config: Config(
        components: [
          Component<_Screen, _Args>(
            path: 'components',
            name: 'Component',
            stories: [storyA, storyB],
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

  Future<void> select(WidgetTester tester, _Story story) async {
    state.updatePath(story.path);
    await tester.pumpAndSettle();
  }

  group(
    'The workbench preview',
    () {
      testWidgets(
        'when switching to a sibling story, '
        "then it shows the newly selected story's setup state",
        (tester) async {
          await pumpWorkbench(tester);

          await select(tester, storyA);
          expect(find.text('alpha|title'), findsOneWidget);

          await select(tester, storyB);

          expect(find.text('beta|title'), findsOneWidget);
          expect(find.text('alpha|title'), findsNothing);
        },
      );

      testWidgets(
        'when a knob value changes, '
        'then it shows the new value without remounting setup',
        (tester) async {
          await pumpWorkbench(tester);
          await select(tester, storyA);

          final setupMounts = _SetupState.mounts;

          state.updateQueryGroup(
            'title',
            const QueryGroup({'value': 'changed'}),
          );
          await tester.pumpAndSettle();

          expect(find.text('alpha|changed'), findsOneWidget);
          expect(_SetupState.mounts, equals(setupMounts));
        },
      );

      testWidgets(
        'when the state notifies without the story or its args changing, '
        'then nothing is remounted',
        (tester) async {
          await pumpWorkbench(tester);
          await select(tester, storyA);

          final setupMounts = _SetupState.mounts;
          final screenMounts = _ScreenState.mounts;

          state.notifyListeners();
          await tester.pumpAndSettle();
          state.notifyListeners();
          await tester.pumpAndSettle();

          expect(_SetupState.mounts, equals(setupMounts));
          expect(_ScreenState.mounts, equals(screenMounts));
        },
      );
    },
  );
}
