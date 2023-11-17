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
  Widget build(BuildContext context) {
    return Text(data.value);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'data': data.value,
    };
  }

  @override
  TextArgs valueFromQueryGroup(Map<String, String> group) {
    return TextArgs(
      data: data.copyWithValue(
        valueOf<String>(data.name, group)!,
      ),
    );
  }
}
