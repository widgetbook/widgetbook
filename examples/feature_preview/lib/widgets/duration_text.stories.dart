import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'duration_text.dart';

part 'duration_text.stories.g.dart';

const component = ComponentMeta(
  name: 'DurationText',
  path: 'args/duration',
);

const meta = Meta(DurationText.new);

/// Demonstrates DurationArg.
final $Duration = _Story(
  name: 'duration',
  args: _Args(
    duration: DurationArg(const Duration(seconds: 5)),
  ),
);

/// Demonstrates NullableDurationArg.
final $NullableDuration = _Story(
  name: 'durationOrNull',
  args: _Args(
    duration: NullableDurationArg(null),
  ),
);
