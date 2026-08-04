import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

import 'brewing_screen.dart';

part 'brewing_screen.stories.g.dart';

final component = ComponentMeta(
  docsBuilder: (blocks) => blocks.replaceFirst<DartCommentDocBlock>(
    const TextDocBlock('''
Sibling stories that differ only by a fixed arg, alongside a knob.

Switching between them must show the selected phase, and a rebuild that
changes neither the story nor its args must not remount the screen, i.e. the
`mount #` must stay put and the warning must not come back.
'''),
  ),
);

const meta = Meta(BrewingScreen.new);

final $Brewing = _Story(
  args: _Args(phase: Arg.fixed(BrewPhase.brewing)),
);

final $Diluting = _Story(
  args: _Args(phase: Arg.fixed(BrewPhase.diluting)),
);

final $BrewingFinished = _Story(
  args: _Args(phase: Arg.fixed(BrewPhase.brewingFinished)),
);

final $Flushing = _Story(
  args: _Args(phase: Arg.fixed(BrewPhase.flushing)),
);

final $BrewingAborted = _Story(
  args: _Args(phase: Arg.fixed(BrewPhase.brewingAborted)),
);

final $PistonRemoved = _Story(
  args: _Args(phase: Arg.fixed(BrewPhase.pistonRemoved)),
);
