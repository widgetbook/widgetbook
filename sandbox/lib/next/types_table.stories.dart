import 'package:flutter/material.dart';
import 'package:widgetbook/next.dart';
import 'package:widgetbook/widgetbook.dart';

import 'types_table.dart';

part 'types_table.stories.book.dart';

final meta = Meta<TypesTable>();

final $Default = TypesTableStory(
  name: 'Default',
  args: TypesTableArgs(
    duration: Arg.of(Duration.zero), // constant arg (not shown in UI)
    person: const PersonArg(
      value: Person(
        name: 'John Doe',
        age: 42,
      ),
    ),
  ),
);

class PersonArg extends Arg<Person> {
  const PersonArg({
    super.name,
    required super.value,
  });

  @override
  List<Field> get fields => [
        StringField(
          name: '$name.name',
          initialValue: value.name,
        ),
        IntInputField(
          name: '$name.age',
          initialValue: value.age,
        ),
      ];

  @override
  Person valueFromQueryGroup(Map<String, String> group) {
    return Person(
      name: valueOf('$name.name', group)!,
      age: valueOf('$name.age', group)!,
    );
  }

  @override
  PersonArg init({
    required String name,
  }) {
    return PersonArg(
      name: name,
      value: value,
    );
  }
}
