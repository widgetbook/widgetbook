import 'package:flutter/material.dart';

import '../../fields/fields.dart';
import '../common/common.dart';

/// A [WidgetbookAddon] for applying custom widget transformations to use cases.
///
/// The builder addon provides a flexible way to wrap use cases with custom
/// widget builders, enabling developers to apply consistent transformations,
/// decorations, or context modifications across multiple use cases.
///
/// Learn more: https://docs.widgetbook.io/addons/builder-addon
class BuilderAddon extends WidgetbookAddon<void> {
  /// Creates a new instance of [BuilderAddon].
  BuilderAddon({
    required super.name,
    required this.builder,
  });

  /// Custom widget builder function that transforms use case content.
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
