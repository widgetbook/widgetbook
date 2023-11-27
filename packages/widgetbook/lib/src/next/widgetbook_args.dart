import 'package:flutter/material.dart';

import '../fields/fields.dart';
import '../settings/settings.dart';
import 'experimental_badge.dart';

abstract class WidgetbookArgs<T> {
  const WidgetbookArgs();

  List<WidgetbookArg> get list;

  /// Builds the story with this.
  /// If a [group] is given, the values are taken from the group.
  /// Otherwise, the default values are used.
  Widget build(BuildContext context, [Map<String, String>? group]);
}

@optionalTypeArgs
abstract class WidgetbookArg<T> extends FieldsComposable<T> {
  const WidgetbookArg({
    this.name = '<unknown>',
    required this.value,
  });

  final String name;
  final T value;

  @override
  String get groupName => 'args';

  WidgetbookArg<T> init({
    required String name,
  });

  @override
  Widget buildFields(BuildContext context) {
    return Setting(
      name: name,
      trailing: const ExperimentalBadge(),
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
    super.name,
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
  String valueFromQueryGroup(Map<String, String> group) {
    return valueOf(name, group)!;
  }

  @override
  StringArg init({
    required String name,
  }) {
    return StringArg(
      name: name,
      value: value,
    );
  }
}
