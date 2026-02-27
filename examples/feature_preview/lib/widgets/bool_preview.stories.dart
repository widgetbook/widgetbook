import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'bool_preview.dart';

part 'bool_preview.stories.g.dart';

const meta = Meta<BoolPreview>(
  name: 'BoolPreview',
  path: 'args/bool',
);

/// Demonstrates BoolArg.
final $Boolean = _Story(
  name: 'boolean',
  args: _Args(
    isEnabled: BoolArg(true),
  ),
);

/// Demonstrates NullableBoolArg.
final $NullableBoolean = _Story(
  name: 'booleanOrNull',
  args: _Args(
    isEnabled: NullableBoolArg(null),
  ),
);
