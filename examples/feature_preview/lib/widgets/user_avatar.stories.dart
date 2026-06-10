import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'user_avatar.dart';

part 'user_avatar.stories.g.dart';

const component = ComponentMeta(
  name: 'UserAvatar',
  path: 'args/string',
);

const meta = Meta(UserAvatar.new);

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
