import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'knob_entry.dart';
import 'knobs_table.dart';

void main() {
  runApp(const WidgetbookApp());
}

class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    final initialDate = DateTime.now();

    return Widgetbook.material(
      addons: [
        BuilderAddon(
          name: 'Addon',
          builder: (_, child) => Scaffold(
            body: child,
          ),
        ),
      ],
      directories: [
        WidgetbookComponent(
          name: 'Knobs',
          useCases: [
            WidgetbookUseCase(
              name: '',
              builder: (context) {
                return KnobsTable(
                  entries: [
                    KnobEntry<int>(
                      name: 'Int (Input)',
                      regular: context.knobs.int.input(
                        label: 'int.input',
                      ),
                      nullable: context.knobs.intOrNull.input(
                        label: 'intOrNull.input',
                      ),
                    ),
                    KnobEntry<int>(
                      name: 'Int (Slider)',
                      regular: context.knobs.int.slider(
                        label: 'int.slider',
                      ),
                      nullable: context.knobs.intOrNull.slider(
                        label: 'intOrNull.slider',
                      ),
                    ),
                    KnobEntry<double>(
                      name: 'Double (Input)',
                      regular: context.knobs.double.input(
                        label: 'double.input',
                      ),
                      nullable: context.knobs.doubleOrNull.input(
                        label: 'doubleOrNull.input',
                      ),
                    ),
                    KnobEntry<double>(
                      name: 'Double (Slider)',
                      regular: context.knobs.double.slider(
                        label: 'double.slider',
                      ),
                      nullable: context.knobs.doubleOrNull.slider(
                        label: 'doubleOrNull.slider',
                      ),
                    ),
                    KnobEntry<String>(
                      name: 'String',
                      regular: context.knobs.string(
                        label: 'string',
                      ),
                      nullable: context.knobs.stringOrNull(
                        label: 'stringOrNull',
                      ),
                    ),
                    KnobEntry<bool>(
                      name: 'Boolean',
                      regular: context.knobs.boolean(
                        label: 'boolean',
                      ),
                      nullable: context.knobs.booleanOrNull(
                        label: 'booleanOrNull',
                      ),
                    ),
                    KnobEntry<Color>(
                      name: 'Color',
                      builder: (color) => Text(
                        '${color}',
                        style: TextStyle(
                          color: color,
                        ),
                      ),
                      regular: context.knobs.color(
                        label: 'color',
                      ),
                      nullable: context.knobs.colorOrNull(
                        label: 'colorOrNull',
                      ), // N/A
                    ),
                    KnobEntry<Duration>(
                      name: 'Duration',
                      regular: context.knobs.duration(
                        label: 'duration',
                      ),
                      nullable: context.knobs.durationOrNull(
                        label: 'durationOrNull',
                      ),
                    ),
                    KnobEntry<DateTime>(
                      name: 'DateTime',
                      builder: (dateTime) => Text(dateTime.toIso8601String()),
                      regular: context.knobs.dateTime(
                        label: 'dateTime',
                        // Placing DateTime.now() here will cause the date time
                        // and the text field to be out of sync
                        initialValue: initialDate,
                        start: DateTime(initialDate.year - 1),
                        end: DateTime(initialDate.year + 1),
                      ),
                      nullable: context.knobs.dateTimeOrNull(
                        label: 'dateTimeOrNull',
                        start: DateTime(initialDate.year - 1),
                        end: DateTime(initialDate.year + 1),
                      ),
                    ),
                    KnobEntry<Iterable<User>>(
                      name: 'Iterable (segmented)',
                      regular: context.knobs.iterable.segmented(
                        label: 'iterable.segmented',
                        labelBuilder: (value) => value.name,
                        options: List.generate(3, (x) => User('U$x')),
                      ),
                      nullable: context.knobs.iterableOrNull.segmented(
                        label: 'iterableOrNull.segmented',
                        labelBuilder: (value) => value.name,
                        options: List.generate(3, (x) => User('U$x')),
                      ),
                    ),
                    KnobEntry<User>(
                      name: 'Object (dropdown)',
                      regular: context.knobs.object.dropdown(
                        label: 'object.dropdown',
                        labelBuilder: (value) => value.name,
                        options: List.generate(10, (x) => User('U$x')),
                      ),
                      nullable: context.knobs.objectOrNull.dropdown(
                        label: 'objectOrNull.dropdown',
                        labelBuilder: (value) => value.name,
                        options: List.generate(10, (index) => User('U$index')),
                      ),
                    ),
                    KnobEntry<User>(
                      name: 'Object (segmented)',
                      regular: context.knobs.object.segmented(
                        label: 'object.segmented',
                        labelBuilder: (value) => value.name,
                        options: List.generate(3, (x) => User('U$x')),
                      ),
                      nullable: context.knobs.objectOrNull.segmented(
                        label: 'objectOrNull.segmented',
                        labelBuilder: (value) => value.name,
                        options: List.generate(3, (x) => User('U$x')),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}

class User {
  User(this.name);

  final String name;

  @override
  String toString() => 'User{name: $name}';
}
