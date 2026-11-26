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

/// Gives the full-screen layout a phone-sized space, also in scenarios,
/// where stories are otherwise laid out without size constraints.
Widget _phone(BuildContext context, Widget child, LessonSummaryArgs args) {
  return SizedBox(
    width: 390,
    height: 844,
    child: Story.defaultSetup(context, child, args),
  );
}

final $Default = _Story(setup: _phone);

final $Long = _Story(
  setup: _phone,
  args: _Args(
    phraseCount: IntArg(100),
  ),
);
