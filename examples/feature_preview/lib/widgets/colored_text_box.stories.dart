import 'package:flutter/material.dart';

import 'package:widgetbook/widgetbook.dart';

import 'colored_text_box.dart';

part 'colored_text_box.stories.g.dart';

const meta = Meta<ColoredTextBox>(
  name: 'ColoredTextBox',
  path: 'args/color',
);

/// Demonstrates ColorArg.
final $Color = _Story(
  name: 'color',
  args: _Args(
    color: ColorArg(Colors.blue),
  ),
);

/// Demonstrates NullableColorArg.
final $NullableColor = _Story(
  name: 'colorOrNull',
  args: _Args(
    color: NullableColorArg(null),
  ),
);
