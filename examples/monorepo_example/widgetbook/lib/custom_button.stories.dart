import 'package:flutter/material.dart';
import 'package:shared_ui/shared_ui.dart';

import 'package:widgetbook/next.dart';

part 'custom_button.stories.book.dart';

final meta = Meta<CustomButton>();

final $Green = CustomButtonStory(
  name: 'Default',
  args: CustomButtonArgs(
    color: Arg.fixed(Colors.green),
  ),
);

final $Red = CustomButtonStory(
  name: 'Default',
  args: CustomButtonArgs(
    color: Arg.fixed(Colors.red),
  ),
);
