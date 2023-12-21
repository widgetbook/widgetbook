import 'package:flutter/widgets.dart';

import '../core/addon.dart';
import '../fields/fields.dart';

typedef ChildBuilder = Widget Function(BuildContext context, Widget child);

/// An [Addon] for wrapping use-cases with a [builder].
class BuilderAddon extends Addon<void> {
  BuilderAddon({
    required super.name,
    required this.builder,
  });

  final ChildBuilder builder;

  @override
  List<Field> get fields => [];

  @override
  void valueFromQueryGroup(Map<String, String> group) {}

  @override
  Widget buildUseCase(
    BuildContext context,
    Widget child,
    void setting,
  ) {
    return builder(context, child);
  }
}
