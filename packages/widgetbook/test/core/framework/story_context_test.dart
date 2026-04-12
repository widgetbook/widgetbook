import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/helper.dart';

class _CustomThemeData {
  const _CustomThemeData({required this.color});

  final Color color;
}

class _CustomTheme extends InheritedWidget {
  const _CustomTheme({
    required this.data,
    required super.child,
  });

  final _CustomThemeData data;

  static _CustomThemeData of(BuildContext context) {
    final widget = context.dependOnInheritedWidgetOfExactType<_CustomTheme>();
    return widget!.data;
  }

  @override
  bool updateShouldNotify(covariant _CustomTheme oldWidget) {
    return data != oldWidget.data;
  }
}

class _SimpleArgs extends StoryArgs<Text> {
  const _SimpleArgs();

  @override
  List<Arg?> get list => const [];
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
  group('$Story.buildWithConfig', () {
    const themeData = _CustomThemeData(color: Colors.red);

    final config = Config(
      addons: [
        ThemeAddon<_CustomThemeData>(
          {'Red': themeData},
          (context, theme, child) {
            return _CustomTheme(
              data: theme,
              child: child,
            );
          },
        ),
      ],
    );

    testWidgets(
      'given a ThemeAddon with a custom theme, '
      'when accessing the theme via context in builder, '
      'then the theme is accessible',
      (tester) async {
        final story = _TestStory<Text, _SimpleArgs>(
          args: const _SimpleArgs(),
          builder: (context, args) {
            final theme = _CustomTheme.of(context);
            return Text('${theme.color}');
          },
        );

        await tester.pumpWidgetWithState(
          state: WidgetbookState(),
          builder: (context) {
            return story.buildWithConfig(context, config);
          },
        );

        expect(find.text('${Colors.red}'), findsOneWidget);
      },
    );

    testWidgets(
      'given a ThemeAddon with a custom theme, '
      'when accessing the theme via context in setup, '
      'then the theme is accessible',
      (tester) async {
        final story = _TestStory<Text, _SimpleArgs>(
          args: const _SimpleArgs(),
          setup: (context, widget, args) {
            final theme = _CustomTheme.of(context);
            return Text('${theme.color}');
          },
          builder: (context, args) {
            return const Text('unused');
          },
        );

        await tester.pumpWidgetWithState(
          state: WidgetbookState(),
          builder: (context) {
            return story.buildWithConfig(context, config);
          },
        );

        expect(find.text('${Colors.red}'), findsOneWidget);
      },
    );
  });
}
