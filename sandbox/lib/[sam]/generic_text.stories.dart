import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

import 'generic_text.dart';

part 'generic_text.stories.g.dart';

// ignore: strict_raw_type
final meta = Meta<GenericText>(
  docsBuilder: (blocks) => blocks.replaceFirst<DartCommentDocBlock>(
    const TextDocBlock('''
1. Creating a generic Story
2. Using different types for the generic parameters
'''),
  ),
);

final $IntStory = _Story<int>(
  args: _Args.fixed(
    value: 0,
  ),
);

final $BoolStory = _Story<bool>(
  args: _Args.fixed(
    value: false,
  ),
  scenarios: [
    _Scenario<bool>(
      name: 'True',
      args: _Args.fixed(
        value: true,
      ),
    ),
  ],
);
