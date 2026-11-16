import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

import 'lesson_summary.dart';

part 'lesson_summary.stories.g.dart';

final component = ComponentMeta(
  docsBuilder: (blocks) => blocks.replaceFirst<DartCommentDocBlock>(
    const TextDocBlock('''
1. A scrollable screen with a lazily built list and a nested horizontal list
2. Commenting on widgets while scrolling, via the `CommentsAddon`
'''),
  ),
);

const meta = Meta(LessonSummary.new);

final $Default = _Story();

final $Long = _Story(
  args: _Args(
    phraseCount: IntArg(100),
  ),
);
