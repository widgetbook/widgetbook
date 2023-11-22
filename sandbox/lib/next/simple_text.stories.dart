import 'package:flutter/material.dart';
import 'package:widgetbook/next.dart';

part 'simple_text.stories.g.dart';

const metadata = ComponentMetadata(
  type: SimpleText,
);

final $SimpleText = SimpleTextStory(
  name: 'Default',
  args: SimpleTextArgs(
    data: const StringArg(
      name: 'data',
      value: 'Hello World',
    ),
  ),
);

class SimpleText extends StatelessWidget {
  const SimpleText(
    this.data, {
    super.key,
  });

  final String data;

  @override
  Widget build(BuildContext context) {
    return Text(data);
  }
}
