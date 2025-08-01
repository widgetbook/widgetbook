// next version of Widgetbook doesn't have api docs yet
// ignore_for_file: public_member_api_docs

import 'package:flutter/widgets.dart';

import 'const_arg.dart';

typedef ArgBuilder<T> = T Function(BuildContext context);

class BuilderArg<T> extends ConstArg<T> {
  const BuilderArg(
    this.builder,
  ) : super.empty();

  final ArgBuilder<T> builder;

  @override
  T resolve(BuildContext context) => builder(context);
}
