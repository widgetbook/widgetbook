import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'label_badge.dart';

part 'label_badge.stories.book.dart';

final meta = MetaWithArgs<LabelBadge, NumericBadgeInput>();

// This will be used as the default `argsBuilder`
LabelBadge argsBuilder(
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
