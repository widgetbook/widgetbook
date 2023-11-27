import 'package:flutter/widgets.dart';

import '../../next.dart';

class WidgetbookScenario<T> extends StatelessWidget {
  const WidgetbookScenario({
    super.key,
    required this.name,
    this.modes,
    this.args,
    required this.story,
  });

  final String name;
  // ignore: strict_raw_type
  final List<WidgetbookMode>? modes;
  final WidgetbookArgs<T>? args;
  final WidgetbookStory<T> story;

  Widget build(BuildContext context) {
    final effectiveArgs = args ?? story.args;

    return effectiveArgs.build(context);
  }
}
