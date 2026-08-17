import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

import 'setting_toggle.dart';

part 'setting_toggle.stories.g.dart';

const meta = Meta(SettingToggle.new);

final $Default = _Story(
  name: 'Default',
  args: _Args(
    title: StringArg('Package asset'),
    value: BoolArg(false),
    toggleFunction: Arg.fixed(_noop),
  ),
);

void _noop() {}
