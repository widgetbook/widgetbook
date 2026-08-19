import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/core/routing/routing.dart';
import 'package:widgetbook/src/core/state/state.dart';
import 'package:widgetbook/src/core/workbench/workbench.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/helper.dart';

// Regression for https://github.com/widgetbook/widgetbook/issues/1984 when
// stories use a custom `setup` that creates state (the same shape as
// `BlocProvider.create`). #2012 keys inside `Story.defaultSetup`, so that
// state sat above the key and was reused across sibling stories.

/// Captures [label] in [initState] and exposes it through [_Scope], standing
/// in for a provider whose `create` only runs once.
class _CubitLike extends StatefulWidget {
  const _CubitLike({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  State<_CubitLike> createState() => _CubitLikeState();
}

class _CubitLikeState extends State<_CubitLike> {
  static int mounts = 0;

  late final String captured = widget.label;

  @override
  void initState() {
    super.initState();
    mounts++;
  }

  @override
  Widget build(BuildContext context) {
    return _Scope(label: captured, child: widget.child);
  }
}

class _Scope extends InheritedWidget {
  const _Scope({required this.label, required super.child});

  final String label;

  static String of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_Scope>()!.label;
  }

  @override
  bool updateShouldNotify(_Scope oldWidget) => label != oldWidget.label;
}

class _Screen extends StatelessWidget {
  const _Screen({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text('${_Scope.of(context)}|$title');
  }
}

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
        setup: (context, widget, args) => _CubitLike(
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
    _CubitLikeState.mounts = 0;

    storyA = _Story(name: 'A', label: 'alpha');
    storyB = _Story(name: 'B', label: 'beta');

    state = WidgetbookState(
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

  group(
    'A story whose setup creates state',
    () {
      testWidgets(
        'when navigating to a sibling story, '
        'then the preview shows the newly selected story\'s setup state',
        (tester) async {
          await pumpWorkbench(tester);

          state.updatePath(storyA.path);
          await tester.pumpAndSettle();
          expect(find.text('alpha|title'), findsOneWidget);

          state.updatePath(storyB.path);
          await tester.pumpAndSettle();

          expect(find.text('beta|title'), findsOneWidget);
          expect(find.text('alpha|title'), findsNothing);
        },
      );

      testWidgets(
        'when a knob value changes, '
        'then the use case updates without remounting setup',
        (tester) async {
          await pumpWorkbench(tester);

          state.updatePath(storyA.path);
          await tester.pumpAndSettle();
          expect(find.text('alpha|title'), findsOneWidget);

          final mountsAfterSelect = _CubitLikeState.mounts;

          state.updateQueryGroup(
            'title',
            const QueryGroup({'value': 'changed'}),
          );
          await tester.pumpAndSettle();

          expect(find.text('alpha|changed'), findsOneWidget);
          expect(_CubitLikeState.mounts, equals(mountsAfterSelect));
        },
      );

      testWidgets(
        'when the state notifies without the story or its args changing, '
        'then setup keeps its state instead of remounting',
        (tester) async {
          await pumpWorkbench(tester);

          state.updatePath(storyA.path);
          await tester.pumpAndSettle();
          expect(find.text('alpha|title'), findsOneWidget);

          final mountsAfterSelect = _CubitLikeState.mounts;

          state.notifyListeners();
          await tester.pumpAndSettle();
          state.notifyListeners();
          await tester.pumpAndSettle();

          expect(_CubitLikeState.mounts, equals(mountsAfterSelect));
        },
      );
    },
  );
}
