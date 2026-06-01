import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'custom_button.dart';

part 'custom_button.stories.g.dart';

const meta = Meta<CustomButton>();
const iconMeta = Meta<CustomButton>(constructor: CustomButton.icon);

final $Default = _Story(
  args: _Args(
    label: StringArg('Click me'),
  ),
);

final $Add = _IconStory(
  args: _IconArgs(
    icon: Arg.fixed(Icons.add),
    label: StringArg('Add'),
  ),
);

final $Search = _IconStory(
  args: _IconArgs(
    icon: Arg.fixed(Icons.search),
    label: StringArg('Search'),
  ),
);
