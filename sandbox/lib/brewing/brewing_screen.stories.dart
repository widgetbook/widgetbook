import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'brewing_screen.dart';

part 'brewing_screen.stories.g.dart';

/// Reproduces https://github.com/widgetbook/widgetbook/issues/1984.
///
/// Every story here builds the same widget and only uses fixed args, which
/// `StoryArgs.safeList` drops. `Story.defaultSetup` keys the use case subtree
/// by the remaining args, so all four stories share one key and Flutter reuses
/// the element between them.
///
/// To verify: select `Brewing`, then any of its siblings. The preview keeps
/// showing `Brewing`, and the tap counter keeps counting up instead of
/// resetting. Selecting a story under another path and coming back rebuilds
/// the preview.
final component = ComponentMeta(
  path: 'brewing',
  docsBuilder: (blocks) => blocks.replaceFirst<DartCommentDocBlock>(
    const TextDocBlock('''
Reproduces issue #1984: switching between the stories below keeps the previous
story on screen, because they all share the same `Story.defaultSetup` key.
'''),
  ),
);

const meta = Meta(BrewingScreen.new);

final $Brewing = _Story(
  args: _Args.fixed(status: 'Brewing'),
);

final $Diluting = _Story(
  args: _Args.fixed(status: 'Diluting'),
);

final $Flushing = _Story(
  args: _Args.fixed(status: 'Flushing'),
);

final $Finished = _Story(
  args: _Args.fixed(status: 'Finished'),
);
