import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/helper.dart';

class _CounterArgs<TWidget extends Widget> extends StoryArgs<TWidget> {
  _CounterArgs({
    IntArg? initialValueArg,
  }) : initialValueArg = initialValueArg ?? IntArg(1, name: 'initialValue');

  final IntArg initialValueArg;

  int get initialValue => initialValueArg.value;

  @override
  List<Arg?> get list => [initialValueArg];
}

class _TestStory<TWidget extends Widget, TArgs extends StoryArgs<TWidget>>
    extends Story<TWidget, TArgs> {
  _TestStory({
    super.setup,
    required super.args,
    required super.builder,
  });
}

class _StatelessCounter extends StatelessWidget {
  const _StatelessCounter({required this.initialValue});

  final int initialValue;

  @override
  Widget build(BuildContext context) {
    return Text(
      '$initialValue',
      textDirection: TextDirection.ltr,
    );
  }
}

class _StatefulCounter extends StatefulWidget {
  const _StatefulCounter({required this.initialValue});

  final int initialValue;

  @override
  State<_StatefulCounter> createState() => _StatefulCounterState();
}

class _StatefulCounterState extends State<_StatefulCounter> {
  late int value;

  @override
  void initState() {
    super.initState();
    value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('$value'),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            setState(() {
              value += 1;
            });
          },
        ),
      ],
    );
  }
}

void main() {
  group('$Story.setup', () {
    testWidgets(
      'given a stateless widget story, '
      'when an arg updates, '
      'then the widget updates',
      (tester) async {
        final story =
            _TestStory<_StatelessCounter, _CounterArgs<_StatelessCounter>>(
              args: _CounterArgs<_StatelessCounter>(),
              builder: (context, args) {
                return _StatelessCounter(initialValue: args.initialValue);
              },
            );

        await tester.pumpWidgetWithState(
          state: WidgetbookState(),
          builder: (context) {
            return story.buildWithConfig(context, const Config());
          },
        );

        expect(find.text('1'), findsOneWidget);

        final context = tester.element(find.byType(_StatelessCounter));
        story.args.initialValueArg.update(context, 2);
        await tester.pumpAndSettle();

        expect(find.text('2'), findsOneWidget);
      },
    );

    testWidgets(
      'given a stateful widget story with default setup, '
      'when an arg updates, '
      'then local widget state resets to the new arg value',
      (tester) async {
        final story =
            _TestStory<_StatefulCounter, _CounterArgs<_StatefulCounter>>(
              args: _CounterArgs<_StatefulCounter>(),
              builder: (context, args) {
                return _StatefulCounter(initialValue: args.initialValue);
              },
            );

        await tester.pumpWidgetWithState(
          state: WidgetbookState(),
          builder: (context) {
            return story.buildWithConfig(context, const Config());
          },
        );

        expect(find.text('1'), findsOneWidget);

        await tester.findAndTap(find.byIcon(Icons.add));
        expect(find.text('2'), findsOneWidget);

        final context = tester.element(find.byType(_StatefulCounter));
        story.args.initialValueArg.update(context, 5);
        await tester.pumpAndSettle();

        expect(find.text('5'), findsOneWidget);
      },
    );

    testWidgets(
      'given a stateful widget story with a custom setup passthrough, '
      'when an arg updates, '
      'then local widget state is preserved',
      (tester) async {
        final story =
            _TestStory<_StatefulCounter, _CounterArgs<_StatefulCounter>>(
              setup: (context, widget, args) => widget,
              args: _CounterArgs<_StatefulCounter>(),
              builder: (context, args) {
                return _StatefulCounter(initialValue: args.initialValue);
              },
            );

        await tester.pumpWidgetWithState(
          state: WidgetbookState(),
          builder: (context) {
            return story.buildWithConfig(context, const Config());
          },
        );

        expect(find.text('1'), findsOneWidget);

        await tester.findAndTap(find.byIcon(Icons.add));
        expect(find.text('2'), findsOneWidget);

        final context = tester.element(find.byType(_StatefulCounter));
        story.args.initialValueArg.update(context, 5);
        await tester.pumpAndSettle();

        expect(find.text('2'), findsOneWidget);
        expect(find.text('5'), findsNothing);
      },
    );
  });
}
