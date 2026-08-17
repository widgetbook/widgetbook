import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

import 'local_asset_toggle.dart';

part 'local_asset_toggle.stories.g.dart';

const meta = Meta(LocalAssetToggle.new);

final $Default = _Story(
  name: 'Default',
  args: _Args(
    title: StringArg('Local asset'),
    value: BoolArg(false),
  ),
);
