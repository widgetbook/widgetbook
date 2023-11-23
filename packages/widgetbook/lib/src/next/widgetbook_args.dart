import 'package:flutter/material.dart';

import '../fields/fields.dart';
import '../settings/settings.dart';

abstract class WidgetbookArgs<T> {
  const WidgetbookArgs();

  List<WidgetbookArg> get list;

  Widget build(BuildContext context, Map<String, String> group);
}

@optionalTypeArgs
abstract class WidgetbookArg<T> extends FieldsComposable<T> {
  const WidgetbookArg({
    required this.name,
    required this.value,
  });

  final String name;
  final T value;

  @override
  String get groupName => 'args';

  WidgetbookArg<T> copyWithValue(T value);

  @override
  Widget buildFields(BuildContext context) {
    return Setting(
      name: name,
      child: Column(
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
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'group': groupName,
      'fields': fields.map((field) => field.toFullJson()).toList(),
    };
  }
}

class StringArg extends WidgetbookArg<String> {
  const StringArg({
    required super.name,
    super.value = '',
  });

  @override
  List<Field> get fields => [
        StringField(
          name: name,
          initialValue: value,
        ),
      ];

  @override
  StringArg copyWithValue(String value) {
    return StringArg(
      name: name,
      value: value,
    );
  }

  @override
  String valueFromQueryGroup(Map<String, String> group) {
    return valueOf(name, group)!;
  }
}
