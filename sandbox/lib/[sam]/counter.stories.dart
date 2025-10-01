import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'counter.dart';

part 'counter.stories.book.dart';

const meta = Meta<Counter>();

final $Default = CounterStory(
  scenarios: [
    CounterScenario(
      name: '10++',
      args: CounterArgs(
        initialValue: const IntArg(10),
      ),
      run: (tester, args) async {
        await tester.tap(find.byIcon(Icons.add));
        await tester.pumpAndSettle();

        expect(
          find.text('${args.initialValue.value + 1}'),
          findsOneWidget,
        );
      },
    ),
  ],
);
