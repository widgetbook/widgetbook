import 'package:flutter/material.dart' hide ThemeMode;
import 'package:widgetbook/widgetbook.dart';

import '../theme.dart';
import 'label_badge.dart';

part 'label_badge.stories.g.dart';

final meta = MetaWithArgs<LabelBadge, NumericBadgeInput>(
  docs: (docs) => docs.replaceFirst<DocCommentBlock>(
    const TextDocBlock('''
1. Using custom args via `MetaWithArgs`
2. Creating defaults for setup and builder
'''),
  ),
);

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
