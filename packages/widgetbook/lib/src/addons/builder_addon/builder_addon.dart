import 'package:flutter/material.dart';

import '../../fields/fields.dart';
import '../common/common.dart';

/// A [WidgetbookAddon] for wrapping use-cases with a [builder].
class BuilderAddon extends WidgetbookAddon<void> {
  BuilderAddon({
    required super.name,
    required this.builder,
  }) : super(
          initialSetting: null,
        );

  final Widget Function(BuildContext context, Widget child) builder;

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
