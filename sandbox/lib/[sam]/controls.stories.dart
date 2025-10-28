import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

import 'controls.dart';
import 'counter.stories.dart' as counter;

part 'controls.stories.book.dart';

const meta = Meta<Controls>(
  docs: 'Testing out the navigation to other stories and docs.',
);

final $Default = ControlsStory(
  name: 'Default',
  args: ControlsArgs.fixed(
    control1Label: 'Visit Counter Story',
    control2Label: 'Visit Counter Docs',
    onControl1Pressed: () {},
    onControl2Pressed: () {},
  ),
  argsBuilder: (context, args) => Controls(
    control1Label: args.control1Label,
    control2Label: args.control2Label,
    onControl1Pressed: () {
      WidgetbookState.of(context).goToStory(counter.$Default);
    },
    onControl2Pressed: () {
      WidgetbookState.of(context).goToDocs(counter.CounterComponent);
    },
  ),
);
