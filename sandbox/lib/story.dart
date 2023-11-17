import 'package:flutter/material.dart';
import 'package:widgetbook/next.dart';

final $Text = TextStory(
  name: 'Text',
);

class TextStory extends WidgetbookStory<Text, TextArgs> {
  TextStory({
    required super.name,
    super.args = const TextArgs(),
  });
}

class TextArgs extends WidgetbookArgs<Text, TextArgs> {
  const TextArgs({
    this.data = const StringArg(
      name: 'Data',
      value: 'Hello World',
    ),
  });

  final StringArg data;

  @override
  List<WidgetbookArg> get list => [data];

  @override
  Widget build(BuildContext context, Map<String, String> group) {
    final data$value = data.valueFromQueryGroup(group);
    return Text(data$value);
  }
}
