import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

import 'generic_text.dart';

part 'generic_text.stories.book.dart';

// ignore: strict_raw_type
const meta = Meta<GenericText>();

final $IntStory = GenericTextStory<int>(
  args: GenericTextArgs.fixed(
    value: 0,
  ),
);

final $BoolStory = GenericTextStory<bool>(
  args: GenericTextArgs.fixed(
    value: false,
  ),
  scenarios: [
    GenericTextScenario<bool>(
      name: 'True',
      args: GenericTextArgs.fixed(
        value: true,
      ),
    ),
  ],
);
