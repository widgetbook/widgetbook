import 'package:flutter/material.dart';

enum Status {
  none,
  loading,
  success,
  error,
}

class TypesTable extends StatelessWidget {
  const TypesTable({
    super.key,

    // Primitive Params
    required this.boolean, // Nullable-Required
    this.integer = 1, // Nullable-Default
    this.decimal, // Nullable
    required this.string, // Required
    this.color = Colors.red, // Default
    required this.duration,
    required this.status,
    // Object Params
    required this.person, // Nullable-Required
    this.margin = const EdgeInsets.all(16), // Nullable-Default
    this.padding, // Nullable
    required this.child, // Required
    this.decoration = const BoxDecoration(), // Default
    // Generics/Function Params
    this.future,
    this.onChanged,
  });

  final bool? boolean;
  final int? integer;
  final double? decimal;
  final String string;
  final Color color;
  final Duration duration;
  final Status status;

  final Person? person;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Decoration decoration;
  final Widget child;

  final Future<bool?>? future;
  final ValueChanged<bool?>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      decoration: decoration,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(32),
            child: child,
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: 600,
            ),
            child: Table(
              children: [
                const TableRow(
                  children: [
                    Text('Type'),
                    Text('Value'),
                  ],
                ),
                TableRow(
                  children: [
                    Text('$bool'),
                    Text('$boolean'),
                  ],
                ),
                TableRow(
                  children: [
                    Text('$int'),
                    Text('$integer'),
                  ],
                ),
                TableRow(
                  children: [
                    Text('$double'),
                    Text('$decimal'),
                  ],
                ),
                TableRow(
                  children: [
                    Text('$String'),
                    Text(string),
                  ],
                ),
                TableRow(
                  children: [
                    Text('$Color'),
                    Text('$color'),
                  ],
                ),
                TableRow(
                  children: [
                    Text('$Duration'),
                    Text('$duration'),
                  ],
                ),
                TableRow(
                  children: [
                    Text('$Person'),
                    Text(person?.toString() ?? '-'),
                  ],
                ),
                TableRow(
                  children: [
                    Text('$Status'),
                    Text('${status.name}'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Person {
  const Person({
    required this.name,
    required this.age,
  });

  final String name;
  final int age;

  @override
  String toString() {
    return '$name ($age)';
  }
}
