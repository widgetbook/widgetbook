import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'counter.dart';

part 'counter.stories.book.dart';

const meta = Meta<Counter>(
  docs: '''
1. Defining a scenario with args
2. Using the `run` callback to define interaction tests
''',
);

final $Default = CounterStory(
  args: CounterArgs(
    onChanged: BuilderArg(
      (context) => (value) {
        final args = WidgetbookState.of(context).story!.args as CounterArgs;
        args.initialValueArg.update(context, value);
      },
    ),
  ),
  scenarios: [
    CounterScenario(
      name: '10++',
      args: CounterArgs(
        initialValue: IntArg(10),
      ),
      run: (tester, args) async {
        await tester.tap(find.byIcon(Icons.add));
        await tester.pumpAndSettle();

        expect(
          find.text('${args.initialValue + 1}'),
          findsOneWidget,
        );
      },
    ),
  ],
);
