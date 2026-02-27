import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'online_status.dart';

part 'online_status.stories.g.dart';

const meta = Meta<OnlineStatusBadge>(
  name: 'OnlineStatusBadge',
  path: 'args/enum',
);

/// Demonstrates EnumArg with dropdown style.
final $EnumDropdown = _Story(
  name: 'enum.dropdown',
  args: _Args(
    status: EnumArg<OnlineStatusType>(
      OnlineStatusType.online,
      values: OnlineStatusType.values,
    ),
  ),
);

/// Demonstrates NullableEnumArg with dropdown style.
final $NullableEnumDropdown = _Story(
  name: 'enumOrNull.dropdown',
  args: _Args(
    status: NullableEnumArg<OnlineStatusType>(
      null,
      values: OnlineStatusType.values,
    ),
  ),
);

/// Demonstrates EnumArg with segmented style.
final $EnumSegmented = _Story(
  name: 'enum.segmented',
  args: _Args(
    status: EnumArg<OnlineStatusType>(
      OnlineStatusType.online,
      values: OnlineStatusType.values,
      style: const SegmentedSingleArgStyle(),
    ),
  ),
);

/// Demonstrates NullableEnumArg with segmented style.
final $NullableEnumSegmented = _Story(
  name: 'enumOrNull.segmented',
  args: _Args(
    status: NullableEnumArg<OnlineStatusType>(
      null,
      values: OnlineStatusType.values,
      style: const SegmentedSingleArgStyle(),
    ),
  ),
);
