import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

import 'generic_text.dart';

part 'generic_text.stories.book.dart';

// ignore: strict_raw_type
const meta = Meta<GenericText>(
  docs: '''
1. Creating a generic Story
2. Using different types for the generic parameters
''',
);

final $IntStory = GenericTextStory<int>(
  args: (_) => GenericTextArgs.fixed(
    value: 0,
  ),
);

final $BoolStory = GenericTextStory<bool>(
  args: (_) => GenericTextArgs.fixed(
    value: false,
  ),
  scenarios: [
    GenericTextScenario<bool>(
      name: 'True',
      args: (_) => GenericTextArgs.fixed(
        value: true,
      ),
    ),
  ],
);
