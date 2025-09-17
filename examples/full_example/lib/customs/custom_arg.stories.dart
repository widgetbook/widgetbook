import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'custom_arg.dart';

part 'custom_arg.stories.book.dart';

const meta = Meta<RangeSlider>();

final $Default = RangeSliderStory(
  name: 'Default',
  args: RangeSliderArgs(
    values: RangeArg(
      const RangeValues(1, 10),
    ),
    min: Arg.fixed(1),
    max: Arg.fixed(10),
    onChanged: Arg.fixed((_) {}),
  ),
);
