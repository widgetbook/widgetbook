import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

class TestStoryArgs extends StoryArgs<SizedBox> {
  const TestStoryArgs();

  @override
  List<Arg?> get list => const [];
}

class TestStory extends Story<SizedBox, TestStoryArgs> {
  TestStory({required super.name})
    : super(
        args: const TestStoryArgs(),
        builder: (_, __) => const SizedBox.shrink(),
      );
}
