import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'user_avatar.dart';

part 'user_avatar.stories.g.dart';

const meta = Meta<UserAvatar>(
  name: 'UserAvatar',
  path: 'args/string',
);

/// Demonstrates StringArg.
final $String = _Story(
  name: 'string',
  args: _Args(
    name: StringArg('Jane Doe'),
  ),
);

/// Demonstrates NullableStringArg.
final $NullableString = _Story(
  name: 'stringOrNull',
  args: _Args(
    name: NullableStringArg(null),
  ),
);
