import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

class TestStoryArgs extends StoryArgs<SizedBox> {
  const TestStoryArgs();

  @override
  List<Arg?> get list => const [];
}

typedef TestScenario = Scenario<SizedBox, TestStoryArgs>;

class TestStory extends Story<SizedBox, TestStoryArgs> {
  TestStory({
    required super.name,
    super.modes,
    super.scenarios = const [],
    TestStoryArgs? args,
  }) : super(
         args: args ?? const TestStoryArgs(),
         builder: (_, __) => const SizedBox.shrink(),
       );
}
