import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'progress_preview.dart';

part 'progress_preview.stories.g.dart';

const meta = Meta<ProgressPreview>(
  name: 'ProgressPreview',
  path: 'args/double',
);

/// Demonstrates DoubleArg with text input style.
final $DoubleInput = _Story(
  name: 'double.input',
  args: _Args(
    progress: DoubleArg(0.5),
  ),
);

/// Demonstrates NullableDoubleArg with text input style.
final $NullableDoubleInput = _Story(
  name: 'doubleOrNull.input',
  args: _Args(
    progress: NullableDoubleArg(null),
  ),
);

/// Demonstrates DoubleArg with slider style.
final $DoubleSlider = _Story(
  name: 'double.slider',
  args: _Args(
    progress: DoubleArg(
      0.5,
      style: const SliderDoubleArgStyle(min: 0.0, max: 1.0, divisions: 10),
    ),
  ),
);

/// Demonstrates NullableDoubleArg with slider style.
final $NullableDoubleSlider = _Story(
  name: 'doubleOrNull.slider',
  args: _Args(
    progress: NullableDoubleArg(
      null,
      style: const SliderDoubleArgStyle(min: 0.0, max: 1.0, divisions: 10),
    ),
  ),
);
