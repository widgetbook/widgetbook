import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'datetime_text.dart';

part 'datetime_text.stories.g.dart';

const component = ComponentMeta(
  name: 'DateTimeText',
  path: 'args/datetime',
);

const meta = Meta(DateTimeText.new);

/// Demonstrates DateTimeArg.
final $DateTime = _Story(
  name: 'dateTime',
  args: _Args(
    dateTime: DateTimeArg(DateTime(2026)),
  ),
);

/// Demonstrates NullableDateTimeArg.
final $NullableDateTime = _Story(
  name: 'dateTimeOrNull',
  args: _Args(
    dateTime: NullableDateTimeArg(null),
  ),
);
