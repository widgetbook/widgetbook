import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'generic_num.dart';

part 'generic_num.stories.book.dart';

// ignore: strict_raw_type
const meta = MetaWithArgs<GenericNum, GenericNumInput>(
  docs: '''
1. Creating a generic Story with custom args
''',
);

class GenericNumInput<T extends num, R> {
  const GenericNumInput({
    required this.number,
    required this.other,
  });

  final T number;
  final R other;
}

Widget $setup<T extends num, R>(
  BuildContext context,
  Widget child,
  _Args<T, R> args,
) {
  return Container(
    child: child,
  );
}

GenericNum<T> $builder<T extends num, R>(
  BuildContext context,
  _Args<T, R> args,
) {
  return GenericNum<T>(
    value: args.number,
  );
}

final $Integer = _Story<int, String>(
  args: _Args.fixed(
    number: 0,
    other: 'foo',
  ),
);

final $Double = _Story<double, Color>(
  args: _Args.fixed(
    number: 0.0,
    other: Colors.black,
  ),
);
