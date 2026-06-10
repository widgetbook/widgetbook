import 'package:flutter/material.dart' hide ThemeMode;
import 'package:widgetbook/widgetbook.dart';

import '../theme.dart';
import 'label_badge.dart';

part 'label_badge.stories.g.dart';

final component = ComponentMeta(
  docsBuilder: (blocks) => blocks.replaceFirst<DartCommentDocBlock>(
    const TextDocBlock('''
1. Using custom args via `Meta.argsType`
2. Creating defaults for setup and builder
'''),
  ),
);

const meta = Meta(LabelBadge.new, argsType: NumericBadgeInput.new);

final defaults = _Defaults(
  setup: (context, child, args) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: Colors.grey[300],
      child: child,
    );
  },
  builder: (context, args) {
    return LabelBadge(
      text: args.number.toString(),
    );
  },
);

final $Primary = _Story(
  args: _Args(
    number: IntArg(
      1,
      style: const SliderIntArgStyle(
        min: 0,
        max: 10,
        divisions: 10,
      ),
    ),
  ),
  scenarios: [
    _Scenario(
      name: 'Dark - 3',
      modes: [
        ThemeMode<MultiThemeData>('Dark', multiDarkTheme, multiThemeBuilder),
      ],
      args: _Args(
        number: IntArg(3),
      ),
    ),
  ],
);

final $Secondary = _Story(
  name: 'Custom Name',
  args: _Args(
    number: IntArg(2),
  ),
);

class NumericBadgeInput {
  NumericBadgeInput({
    required this.number,
  });

  final int number;
}
