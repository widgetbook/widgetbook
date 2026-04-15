import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/helper.dart';

/// A simple InheritedWidget that provides a user name,
/// simulating an authentication provider injected via [Story.setup].
class _UserProvider extends InheritedWidget {
  const _UserProvider({
    required this.userName,
    required super.child,
  });

  final String userName;

  static _UserProvider of(BuildContext context) {
    final provider = context
        .dependOnInheritedWidgetOfExactType<_UserProvider>();
    assert(provider != null, 'No _UserProvider found in context');
    return provider!;
  }

  @override
  bool updateShouldNotify(_UserProvider oldWidget) {
    return userName != oldWidget.userName;
  }
}

/// A widget that reads its data from [_UserProvider] in its build method,
/// simulating a component that depends on an inherited widget.
class _UserProfile extends StatelessWidget {
  const _UserProfile();

  @override
  Widget build(BuildContext context) {
    final provider = _UserProvider.of(context);
    return Text(provider.userName);
  }
}

class _SimpleArgs<TWidget extends Widget> extends StoryArgs<TWidget> {
  @override
  List<Arg?> get list => [];
}

class _BuilderArgArgs extends StoryArgs<Text> {
  _BuilderArgArgs()
      : userNameArg = BuilderArg<String>(
          (context) => _UserProvider.of(context).userName,
        );

  final BuilderArg<String> userNameArg;

  String get userName => userNameArg.value;

  @override
  List<Arg?> get list => [userNameArg];
}

class _TestStory<TWidget extends Widget, TArgs extends StoryArgs<TWidget>>
    extends Story<TWidget, TArgs> {
  _TestStory({
    super.setup,
    required super.args,
    required super.builder,
  });
}

void main() {
  group('$Story setup/builder context', () {
    testWidgets(
      'given a setup that injects an InheritedWidget, '
      'when the built widget accesses it via its BuildContext, '
      'then the InheritedWidget should be resolvable',
      (tester) async {
        final story = _TestStory<_UserProfile, _SimpleArgs<_UserProfile>>(
          setup: (context, child, args) {
            return _UserProvider(
              userName: 'Alice',
              child: child,
            );
          },
          args: _SimpleArgs<_UserProfile>(),
          builder: (context, args) {
            return const _UserProfile();
          },
        );

        await tester.pumpWidgetWithState(
          state: WidgetbookState(),
          builder: (context) {
            return story.buildWithConfig(context, const Config());
          },
        );

        expect(find.text('Alice'), findsOneWidget);
      },
    );

    testWidgets(
      'given a setup that injects an InheritedWidget, '
      'when a BuilderArg resolves its value from context, '
      'then the InheritedWidget should be resolvable',
      (tester) async {
        final story = _TestStory<Text, _BuilderArgArgs>(
          setup: (context, child, args) {
            return _UserProvider(
              userName: 'Alice',
              child: child,
            );
          },
          args: _BuilderArgArgs(),
          builder: (context, args) {
            return Text(args.userName);
          },
        );

        await tester.pumpWidgetWithState(
          state: WidgetbookState(),
          builder: (context) {
            return story.buildWithConfig(context, const Config());
          },
        );

        expect(find.text('Alice'), findsOneWidget);
      },
    );
  });
}
