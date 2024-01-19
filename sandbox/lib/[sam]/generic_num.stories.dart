import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

import 'generic_num.dart';

part 'generic_num.stories.book.dart';

final meta = MetaWithArgs<GenericNum, GenericNumInput>();

class GenericNumInput<T extends num> {
  const GenericNumInput({
    required this.number,
  });

  final T number;
}

// TODO: support global argsBuilder/setup for generic types
GenericNum<T> $argsBuilder<T extends num>(
  BuildContext context,
  GenericNumInputArgs<T> args,
) {
  return GenericNum(
    value: args.number.resolve(context),
  );
}

final $Integer = GenericNumStory<int>(
  argsBuilder: $argsBuilder,
  args: GenericNumInputArgs(
    number: Arg.fixed(0),
  ),
);

final $Double = GenericNumStory<double>(
  argsBuilder: $argsBuilder,
  args: GenericNumInputArgs(
    number: Arg.fixed(0.0),
  ),
);
