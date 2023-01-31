import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

class Person {
  const Person({
    required this.name,
    required this.age,
  });

  final String name;
  final int age;
}

@WidgetbookUseCase(name: 'Default', type: OptionKnob)
Widget optionKnob(BuildContext context) {
  const john = Person(name: 'John Doe', age: 24);
  const jane = Person(name: 'Jane Doe', age: 20);
  return OptionKnob(
    name: 'Is enabled',
    description: 'This is a description.',
    values: const [
      john,
      jane,
    ],
    value: jane,
    labelBuilder: (person) => person.name,
  );
}
