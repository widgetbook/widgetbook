import 'package:flutter/widgets.dart';
import 'package:widgetbook/src/core/settings/nullable_setting.dart';
import 'package:widgetbook/widgetbook.dart';

part 'nullable_setting.stories.g.dart';

final meta = Meta<NullableSetting>(
  path: 'widgetbook/settings',
  docsBuilder: (blocks) => blocks.insertAfter<DartCommentDocBlock>(
    const TextDocBlock('''
1. Using a custom `path`
2. Using `Story.modes` to use `ViewportMode` and limit the scenarios width
'''),
  ),
);

final $Default = _Story(
  args: _Args(
    name: StringArg('Knob'),
    child: Arg.fixed(
      const Placeholder(),
    ),
  ),
  modes: [
    // These modes will be applied to all scenarios under this story
    // including the ones that are coming from `ScenarioDefinition`s.
    ViewportMode(
      const ViewportData.constrained(
        name: '800w',
        maxWidth: 800,
        pixelRatio: 2,
        platform: TargetPlatform.iOS,
      ),
    ),
  ],
  scenarios: [
    _Scenario(
      name: 'Long name (600w)',
      modes: [
        // These modes will get merged with the modes defined in the story
        // and they have more precedence.
        ViewportMode(
          const ViewportData.constrained(
            name: '600w',
            maxWidth: 600,
            pixelRatio: 2,
            platform: TargetPlatform.iOS,
          ),
        ),
      ],
      args: _Args(
        name: StringArg(
          'This is a very long name to test overflow behavior',
        ),
        child: Arg.fixed(
          const Placeholder(),
        ),
      ),
    ),
  ],
);
