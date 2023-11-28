import 'package:flutter/material.dart';
import 'package:widgetbook/next.dart';

part 'simple_text.stories.g.dart';

final meta = Meta<SimpleText>(
  name: 'Simple Text',
);

final $SimpleText = SimpleTextStory(
  name: 'Default',
  args: SimpleTextArgs(
    data: const StringArg(
      value: 'Hello World',
    ),
  ),
);

class SimpleText extends StatelessWidget {
  const SimpleText({
    super.key,
    required this.data,
  });

  final String data;

  @override
  Widget build(BuildContext context) {
    return Text(data);
  }
}
