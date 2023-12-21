import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'label_badge.dart';

part 'label_badge.stories.book.dart';

final meta = MetaWithArgs<LabelBadge, NumericBadgeInput>(
  path: '[sam]/stories',
);

LabelBadge argsBuilder(
  BuildContext context,
  NumericBadgeInputArgs args,
) {
  return LabelBadge(
    text: args.number.resolve(context).toString(),
  );
}

final $Primary = LabelBadgeStory(
  name: 'Primary',
  args: NumericBadgeInputArgs(
    number: const IntArg(1),
  ),
  argsBuilder: argsBuilder,
);

final $Secondary = LabelBadgeStory(
  name: 'Secondary',
  args: NumericBadgeInputArgs(
    number: const IntArg(2),
  ),
  argsBuilder: argsBuilder,
);

class NumericBadgeInput {
  NumericBadgeInput({
    required this.number,
  });

  final int number;
}
