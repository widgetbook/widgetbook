import 'package:flutter/widgets.dart';
import 'package:widgetbook/src/settings/settings_panel.dart';
import 'package:widgetbook/widgetbook.dart';

part 'settings_panel.stories.book.dart';

final meta = Meta<SettingsPanel>();

final $Default = SettingsPanelStory(
  name: 'Default',
  args: SettingsPanelArgs(
    settings: Arg.fixed(
      [
        SettingsPanelData(
          name: 'Addons',
          builder: (_) => [],
        ),
        SettingsPanelData(
          name: 'Knobs',
          builder: (_) => [],
        ),
      ],
    ),
  ),
);
