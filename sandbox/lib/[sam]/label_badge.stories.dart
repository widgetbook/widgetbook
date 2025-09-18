import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'label_badge.dart';

part 'label_badge.stories.book.dart';

const meta = MetaWithArgs<LabelBadge, NumericBadgeInput>();

// This will be used as the default `setup`
Widget $setup(
  BuildContext context,
  Widget child,
  NumericBadgeInputArgs args,
) {
  return Container(
    padding: const EdgeInsets.all(8),
    color: Colors.grey[300],
    child: child,
  );
}

// This will be used as the default `argsBuilder`
LabelBadge $argsBuilder(
  BuildContext context,
  NumericBadgeInputArgs args,
) {
  return LabelBadge(
    text: args.number.resolve(context).toString(),
  );
}

final $Primary = LabelBadgeStory(
  args: NumericBadgeInputArgs(
    number: const IntArg(1),
  ),
  scenarios: [
    LabelBadgeScenario(
      name: 'Dark - 3',
      modes: [MaterialThemeMode(ThemeData.dark())],
      args: NumericBadgeInputArgs(
        number: const IntArg(3),
      ),
    ),
  ],
);

final $Secondary = LabelBadgeStory(
  name: 'Custom Name',
  args: NumericBadgeInputArgs(
    number: const IntArg(2),
  ),
);

class NumericBadgeInput {
  NumericBadgeInput({
    required this.number,
  });

  final int number;
}
