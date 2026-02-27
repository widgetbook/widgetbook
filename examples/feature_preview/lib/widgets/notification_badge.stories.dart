import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'notification_badge.dart';

part 'notification_badge.stories.g.dart';

const meta = Meta<NotificationBadge>(
  name: 'NotificationBadge',
  path: 'args/int',
);

/// Demonstrates IntArg with text input style.
final $IntInput = _Story(
  name: 'int.input',
  args: _Args(
    count: IntArg(5),
  ),
);

/// Demonstrates NullableIntArg with text input style.
final $NullableIntInput = _Story(
  name: 'intOrNull.input',
  args: _Args(
    count: NullableIntArg(null),
  ),
);

/// Demonstrates IntArg with slider style.
final $IntSlider = _Story(
  name: 'int.slider',
  args: _Args(
    count: IntArg(
      5,
      style: const SliderIntArgStyle(min: 0, max: 200, divisions: 20),
    ),
  ),
);

/// Demonstrates NullableIntArg with slider style.
final $NullableIntSlider = _Story(
  name: 'intOrNull.slider',
  args: _Args(
    count: NullableIntArg(
      null,
      style: const SliderIntArgStyle(min: 0, max: 200, divisions: 20),
    ),
  ),
);
