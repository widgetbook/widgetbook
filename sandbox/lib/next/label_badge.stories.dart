import 'package:flutter/widgets.dart';
import 'package:widgetbook/next.dart';

import 'label_badge.dart';

part 'label_badge.stories.book.dart';

final meta = MetaWithArgs<LabelBadge, NumericBadgeInput>(
  argsBuilder: (context, args) {
    final typedArgs = args as NumericBadgeInputArgs;
    return LabelBadge(
      text: typedArgs.number.resolve(context).toString(),
    );
  },
);

final $Default = LabelBadgeStory(
  name: 'Default',
  args: NumericBadgeInputArgs(
    number: const IntArg(1),
  ),
);

class NumericBadgeInput {
  NumericBadgeInput({
    required this.number,
  });

  final int number;
}
