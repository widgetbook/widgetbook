import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'custom_button.dart';

part 'custom_button_icon.stories.g.dart';

const meta = Meta<CustomButton>(
  constructor: CustomButton.icon,
);

final $Default = _Story(
  args: _Args(
    icon: Arg.fixed(Icons.add),
    label: StringArg('Add'),
  ),
);

final $Search = _Story(
  args: _Args(
    icon: Arg.fixed(Icons.search),
    label: StringArg('Search'),
  ),
);
