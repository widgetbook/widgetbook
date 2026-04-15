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
      'when the builder accesses it via its context parameter, '
      'then the InheritedWidget should be resolvable',
      (tester) async {
        final story = _TestStory<Text, _SimpleArgs<Text>>(
          setup: (context, widget, args) {
            return _UserProvider(
              userName: 'Alice',
              child: widget,
            );
          },
          args: _SimpleArgs<Text>(),
          builder: (context, args) {
            final provider = _UserProvider.of(context);
            return Text(provider.userName);
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
