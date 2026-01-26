import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'stepped_counter.dart';

part 'stepped_counter.stories.g.dart';

const meta = Meta<SteppedCounter>();

final _key = GlobalKey();

final $Default = _Story(
  name: 'Default',
  args: _Args(
    key: Arg.fixed(_key), // To prevent losing state
  ),
);
