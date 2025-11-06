import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'types_table.dart';

part 'types_table.stories.book.dart';

const meta = Meta<TypesTable>(
  docs: '''
1. All possible combinations of parameters (required, optional, with default values)
2. Defining scenarios with different args
3. Defining a custom Arg type `PersonArg`
''',
);

final $Default = _Story(
  setup: (context, child, args) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.red,
          width: args.decimal ?? 0,
        ),
      ),
      child: child,
    );
  },
  args: _Args(
    string: StringArg(
      'Hello World',
      name: 'Text',
    ),
    duration: Arg.fixed(Duration.zero),
    person: PersonArg(
      const Person(
        name: 'John Doe',
        age: 42,
      ),
    ),
    child: Arg.fixed(
      const FlutterLogo(),
    ),
  ),
  scenarios: [
    _Scenario(
      name: 'Default',
    ),
    _Scenario(
      name: 'Placeholder Child',
      args: _Args.fixed(
        child: const Placeholder(),
      ),
    ),
  ],
);

class PersonArg extends Arg<Person> {
  PersonArg(
    super.value, {
    super.name,
  });

  @override
  List<Field> get fields => [
    StringField(
      name: 'name',
      initialValue: value.name,
    ),
    IntInputField(
      name: 'age',
      initialValue: value.age,
    ),
  ];

  @override
  Person valueFromQueryGroup(QueryGroup? group) {
    if (group == null || group.isNullified) return value;

    return Person(
      name: valueOf('name', group),
      age: valueOf('age', group),
    );
  }

  @override
  QueryGroup valueToQueryGroup(Person value) {
    return QueryGroup({
      'name': paramOf('name', value.name),
      'age': paramOf('age', value.age),
    });
  }
}
