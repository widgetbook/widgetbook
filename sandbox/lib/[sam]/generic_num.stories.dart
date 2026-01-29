import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'generic_num.dart';

part 'generic_num.stories.g.dart';

// ignore: strict_raw_type
final meta = MetaWithArgs<GenericNum, GenericNumInput>(
  docs: (docs) => docs.replaceFirst<DocCommentsBlock>(
    const TextBlock('''
1. Creating a generic Story with custom args
'''),
  ),
);

final defaults = _Defaults(
  setup: (context, child, args) {
    return switch (args) {
      GenericNumInputArgs<num, Color> x => Container(
        color: x.other,
        child: child,
      ),
      _ => child,
    };
  },
  builder: (context, args) {
    return GenericNum(
      value: args.number,
    );
  },
);

final $Integer = _Story<int, String>(
  args: _Args.fixed(
    number: 0,
    other: 'foo',
  ),
);

final $Double = _Story<double, Color>(
  args: _Args.fixed(
    number: 0.0,
    other: Colors.red,
  ),
);

// Custom args class instead of using widget's parameters
class GenericNumInput<T extends num, R> {
  const GenericNumInput({
    required this.number,
    required this.other,
  });

  final T number;
  final R other;
}
