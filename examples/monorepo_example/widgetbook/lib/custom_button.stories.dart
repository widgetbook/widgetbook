import 'package:flutter/material.dart';
import 'package:shared_ui/shared_ui.dart';

import 'package:widgetbook/widgetbook.dart';

part 'custom_button.stories.g.dart';

const meta = Meta<CustomButton>();

final $Green = _Story(
  name: 'Default',
  args: _Args(
    color: Arg.fixed(Colors.green),
  ),
);

final $Red = _Story(
  name: 'Default',
  args: _Args(
    color: Arg.fixed(Colors.red),
  ),
);
