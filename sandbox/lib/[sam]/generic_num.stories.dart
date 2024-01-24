import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'generic_num.dart';

part 'generic_num.stories.book.dart';

// ignore: strict_raw_type
final meta = MetaWithArgs<GenericNum, GenericNumInput>();

class GenericNumInput<T extends num, R> {
  const GenericNumInput({
    required this.number,
    required this.other,
  });

  final T number;
  final R other;
}

// TODO: support global argsBuilder/setup for generic types
GenericNum<T> $argsBuilder<T extends num, R>(
  BuildContext context,
  GenericNumInputArgs<T, R> args,
) {
  return GenericNum<T>(
    value: args.number.resolve(context),
  );
}

final $Integer = GenericNumStory<int, String>(
  argsBuilder: $argsBuilder,
  args: GenericNumInputArgs.fixed(
    number: 0,
    other: 'foo',
  ),
);

final $Double = GenericNumStory<double, Color>(
  argsBuilder: $argsBuilder,
  args: GenericNumInputArgs.fixed(
    number: 0.0,
    other: Colors.black,
  ),
);
