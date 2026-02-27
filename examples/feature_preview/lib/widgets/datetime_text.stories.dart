import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'datetime_text.dart';

part 'datetime_text.stories.g.dart';

const meta = Meta<DateTimeText>(
  name: 'DateTimeText',
  path: 'args/datetime',
);

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
