import 'package:flutter/material.dart';

import '../fields/fields.dart';

abstract class WidgetbookArgs<T, TSelf> extends FieldsComposable<TSelf> {
  const WidgetbookArgs();

  List<WidgetbookArg> get list;

  Widget build(BuildContext context);

  @override
  String get groupName => 'args';

  @override
  List<Field> get fields => list.map((e) => e.field).toList();

  @override
  Widget buildFields(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: fields
          .map(
            (field) => Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 4.0,
              ),
              child: field.build(context, groupName),
            ),
          )
          .toList(),
    );
  }
}

@optionalTypeArgs
abstract class WidgetbookArg<T> {
  const WidgetbookArg({
    required this.name,
    required this.value,
  });

  final String name;
  final T value;

  Field get field;

  WidgetbookArg<T> copyWithValue(T value);
}

class StringArg extends WidgetbookArg<String> {
  const StringArg({
    required super.name,
    required super.value,
  });

  @override
  Field get field => StringField(
        name: name,
        initialValue: value,
      );

  @override
  StringArg copyWithValue(String value) {
    return StringArg(
      name: name,
      value: value,
    );
  }
}
