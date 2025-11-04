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
  builder: (context, args) {
    return Counter(
      initialValue: args.initialValue,
      onChanged: (value) {
        // Since there's no `BuilderArg` and the `.update` method requires
        // a BuildContext, we pass it down from `builder` and not `args`.
        args.initialValueArg.update(context, value);
      },
    );
  },
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
