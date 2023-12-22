import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'label_badge.dart';

part 'label_badge.stories.book.dart';

final meta = MetaWithArgs<LabelBadge, NumericBadgeInput>();

LabelBadge argsBuilder(
  BuildContext context,
  NumericBadgeInputArgs args,
) {
  return LabelBadge(
    text: args.number.resolve(context).toString(),
  );
}

final $Primary = LabelBadgeStory(
  argsBuilder: argsBuilder,
  args: NumericBadgeInputArgs(
    number: const IntArg(1),
  ),
);

final $Secondary = LabelBadgeStory(
  name: 'Custom Name',
  argsBuilder: argsBuilder,
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
