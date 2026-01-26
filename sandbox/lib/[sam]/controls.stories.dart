import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

import 'controls.dart';
import 'counter.stories.dart' as counter;

part 'controls.stories.g.dart';

const meta = Meta<Controls>(
  docs: 'Testing out the navigation to other stories and docs.',
);

final $Default = _Story(
  name: 'Default',
  args: _Args(
    control1Label: Arg.fixed('Visit Counter Story'),
    onControl1Pressed: BuilderArg(
      (context) => () {
        WidgetbookState.of(context).goToStory(counter.$Default);
      },
    ),
    control2Label: Arg.fixed('Visit Counter Docs'),
    onControl2Pressed: BuilderArg(
      (context) => () {
        WidgetbookState.of(context).goToDocs(counter.CounterComponent);
      },
    ),
  ),
);
