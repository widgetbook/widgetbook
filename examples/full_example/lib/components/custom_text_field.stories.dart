import 'package:flutter/material.dart';
import 'package:widgetbook/next.dart';

import 'custom_text_field.dart';

part 'custom_text_field.stories.book.dart';

final meta = Meta<CustomTextField>();

final $Default = CustomTextFieldStory(
  name: 'Default',
  args: CustomTextFieldArgs(
    controller: Arg.fixed(TextEditingController()),
  ),
);

final $WithHint = CustomTextFieldStory(
  name: 'With Hint',
  args: CustomTextFieldArgs(
    controller: Arg.fixed(TextEditingController()),
    hintText: const StringArg('This is a hint'),
  ),
);
