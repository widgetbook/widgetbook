import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'types_table.dart';

part 'types_table.stories.book.dart';

const meta = Meta<TypesTable>();

final $Default = TypesTableStory(
  setup: (context, child, args) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.red,
          width: args.decimal?.resolve(context) ?? 0,
        ),
      ),
      child: child,
    );
  },
  args: TypesTableArgs(
    string: const StringArg(
      'Hello World',
      name: 'Text',
    ),
    duration: Arg.fixed(Duration.zero),
    person: const PersonArg(
      Person(
        name: 'John Doe',
        age: 42,
      ),
    ),
    child: BuilderArg(
      (context) => const FlutterLogo(),
    ),
  ),
  scenarios: [
    TypesTableScenario(
      name: 'Default',
    ),
    TypesTableScenario(
      name: 'Placeholder Child',
      args: TypesTableArgs.fixed(
        child: const Placeholder(),
      ),
    ),
  ],
);

class PersonArg extends Arg<Person> {
  const PersonArg(
    super.value, {
    super.name,
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
  Map<String, String> valueToQueryGroup(Person value) {
    return {
      '$name.name': paramOf('$name.name', value.name),
      '$name.age': paramOf('$name.age', value.age),
    };
  }

  @override
  PersonArg init({
    required String name,
  }) {
    return PersonArg(
      value,
      name: name,
    );
  }
}
