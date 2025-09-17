import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'stepped_counter.dart';

part 'stepped_counter.stories.book.dart';

const meta = Meta<SteppedCounter>();

final _key = GlobalKey();

final $Default = SteppedCounterStory(
  name: 'Default',
  args: SteppedCounterArgs(
    key: Arg.fixed(_key), // To prevent losing state
  ),
);
