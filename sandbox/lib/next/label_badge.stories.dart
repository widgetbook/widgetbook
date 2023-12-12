import 'package:widgetbook/next.dart';

import 'label_badge.dart';

part 'label_badge.stories.book.dart';

final meta = MetaWithArgs<LabelBadge, NumericBadgeInput>();

final $Default = LabelBadgeStory(
  name: 'Default',
  args: NumericBadgeInputArgs(
    number: const IntArg(1),
  ),
  argsBuilder: (context, args) => LabelBadge(
    text: args.number.resolve(context).toString(),
  ),
);

class NumericBadgeInput {
  NumericBadgeInput({
    required this.number,
  });

  final int number;
}
