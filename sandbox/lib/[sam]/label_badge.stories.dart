import 'package:flutter/material.dart' hide ThemeMode;
import 'package:widgetbook/widgetbook.dart';

import '../theme.dart';
import 'label_badge.dart';

part 'label_badge.stories.book.dart';

const meta = MetaWithArgs<LabelBadge, NumericBadgeInput>(
  docs: '''
1. Using custom args via `MetaWithArgs`
2. Creating a default `setup` function
3. Creating a default `builder` function
''',
);

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

// This will be used as the default `builder`
LabelBadge $builder(
  BuildContext context,
  NumericBadgeInputArgs args,
) {
  return LabelBadge(
    text: args.number.toString(),
  );
}

final $Primary = LabelBadgeStory(
  args: NumericBadgeInputArgs(
    number: IntArg(1),
  ),
  scenarios: [
    LabelBadgeScenario(
      name: 'Dark - 3',
      modes: [
        ThemeMode<MultiThemeData>('Dark', multiDarkTheme, multiThemeBuilder),
      ],
      args: NumericBadgeInputArgs(
        number: IntArg(3),
      ),
    ),
  ],
);

final $Secondary = LabelBadgeStory(
  name: 'Custom Name',
  args: NumericBadgeInputArgs(
    number: IntArg(2),
  ),
);

class NumericBadgeInput {
  NumericBadgeInput({
    required this.number,
  });

  final int number;
}
