import 'package:flutter/widgets.dart';

import '../fields/fields.dart';
import '../framework/framework.dart';

typedef ChildBuilder = Widget Function(BuildContext context, Widget child);

/// An [Addon] for wrapping use-cases with a [builder].
class BuilderAddon extends Addon<void> with NoFields {
  BuilderAddon({
    required super.name,
    required this.builder,
  }) : super(initialValue: null);

  final ChildBuilder builder;

  @override
  Widget apply(
    BuildContext context,
    Widget child,
    void setting,
  ) {
    return builder(context, child);
  }
}
