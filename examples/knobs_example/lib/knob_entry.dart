import 'package:flutter/material.dart';

Widget _defaultBuilder(dynamic value) {
  return Text(value.toString());
}

class KnobEntry<T> {
  KnobEntry({
    required this.name,
    this.builder = _defaultBuilder,
    required this.regular,
    required this.nullable,
  });

  final String name;
  final T regular;
  final T? nullable;
  final Widget Function(T value) builder;

  Widget toRegularWidget() {
    return builder(regular);
  }

  Widget toNullableWidget() {
    return nullable == null
        ? ColoredBox(
            color: Colors.red[50]!,
            child: const Text(''),
          )
        : builder(nullable!);
  }
}
