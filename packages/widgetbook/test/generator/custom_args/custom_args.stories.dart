import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

part 'custom_args.stories.g.dart';

/// Tests Meta(LabelBadge.new, argsType: NumericBadgeInput.new) where the
/// custom args type has different fields (int number) than the widget
/// (String text). Verifies that the Args class is derived from
/// NumericBadgeInput (not LabelBadge), that a defaults variable with a builder
/// is required when using a custom args type, that the generated builder
/// parameter is optional, and that defaults.builder is piped into the Story
/// super constructor.
const description = 'generates required builder when using a custom args type';

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

const meta = Meta(LabelBadge.new, argsType: NumericBadgeInput.new);

final defaults = _Defaults(
  builder: (context, args) => LabelBadge(text: args.number.toString()),
);

final $Default = _Story();
