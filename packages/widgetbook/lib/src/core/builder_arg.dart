import 'package:flutter/widgets.dart';

import '../routing/routing.dart';
import 'const_arg.dart';

typedef ArgBuilder<T> = T Function(BuildContext context);

class BuilderArg<T> extends ConstArg<T> {
  BuilderArg(
    this.builder,
  ) : super.empty();

  final ArgBuilder<T> builder;

  void syncValueWithContext(BuildContext context) {
    value = builder(context);
  }

  @override
  void syncValueWithQueryGroup(QueryGroup? group) {
    // No-op: BuilderArg's value is determined by its builder.
  }

  @override
  void resetValue() {
    // No-op: BuilderArg does not have a resettable value.
  }

  @override
  void update(BuildContext context, T newValue) {
    value = newValue;
  }
}
