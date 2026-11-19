import 'package:material_ui/material_ui.dart';
import 'package:widgetbook/widgetbook.dart';

import 'custom_arg.dart';

part 'custom_arg.stories.g.dart';

const meta = Meta(RangeSlider.new);

final $Default = _Story(
  name: 'Default',
  args: _Args(
    values: RangeArg(
      const RangeValues(1, 10),
    ),
    min: Arg.fixed(1),
    max: Arg.fixed(10),
    onChanged: Arg.fixed((_) {}),
  ),
);
