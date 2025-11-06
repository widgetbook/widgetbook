import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'custom_text_field.dart';

part 'custom_text_field.stories.book.dart';

const meta = Meta<CustomTextField>();

final $Default = _Story(
  name: 'Default',
  args: _Args(
    controller: Arg.fixed(TextEditingController()),
  ),
);

final $WithHint = _Story(
  name: 'With Hint',
  args: _Args(
    controller: Arg.fixed(TextEditingController()),
    hintText: StringArg('This is a hint'),
  ),
);
