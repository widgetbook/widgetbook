import 'package:flutter/widgets.dart';
import 'package:widgetbook/src/settings/nullable_setting.dart';
import 'package:widgetbook/src/theme/theme.dart';
import 'package:widgetbook/widgetbook.dart';

part 'nullable_setting.stories.book.dart';

const meta = Meta<NullableSetting>(
  path: 'widgetbook/settings',
  docs: '''
1. Using a custom `path`
2. Using `constraints` to limit the scenarios width
''',
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
  scenariosViewport: const ViewportData.constrained(
    name: '800w',
    maxWidth: 800,
    pixelRatio: 2,
    platform: TargetPlatform.iOS,
  ),
  scenarios: [
    NullableSettingScenario(
      name: 'Long name',
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
