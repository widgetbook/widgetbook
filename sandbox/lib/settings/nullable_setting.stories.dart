import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:widgetbook/src/settings/nullable_setting.dart';
import 'package:widgetbook/src/theme/theme.dart';
import 'package:widgetbook/widgetbook.dart';

part 'nullable_setting.stories.book.dart';

const meta = Meta<NullableSetting>(
  path: 'widgetbook/settings',
);

final $Default = NullableSettingStory(
  args: NullableSettingArgs(
    name: const StringArg('Knob'),
    child: Arg.fixed(
      const Placeholder(),
    ),
  ),
  setup: (context, child, args) {
    // Needed for text-styling.
    // The theme is not yet provided by a global addon/mode.
    return WidgetbookTheme(
      data: Themes.light,
      child: child,
    );
  },
  scenarios: [
    NullableSettingScenario(
      name: 'Long name',
      constraints: const ViewConstraints(
        maxWidth: 800,
      ),
      args: NullableSettingArgs(
        name: const StringArg(
          'This is a very long name to test overflow behavior',
        ),
        child: Arg.fixed(
          const Placeholder(),
        ),
      ),
    ),
  ],
);
