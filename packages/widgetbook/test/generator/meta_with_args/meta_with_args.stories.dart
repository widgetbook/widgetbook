import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

part 'meta_with_args.stories.g.dart';

class LabelBadge extends StatelessWidget {
  const LabelBadge({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) => Text(text);
}

class NumericBadgeInput {
  const NumericBadgeInput({required this.number});

  final int number;
}

const meta = MetaWithArgs<LabelBadge, NumericBadgeInput>();

final defaults = _Defaults(
  builder: (context, args) => LabelBadge(text: args.number.toString()),
);

final $Default = Object();
