import 'package:flutter/material.dart';

import '../../fields/fields.dart';
import '../common/common.dart';

/// A [WidgetbookAddon] for wrapping use-cases with a [builder].
class UseCaseBuilderAddon extends WidgetbookAddon<bool> {
  UseCaseBuilderAddon({
    required super.name,
    required this.builder,
    bool isEnabled = true,
  }) : super(
          initialSetting: isEnabled,
        );

  final Widget Function(BuildContext context, Widget child) builder;

  @override
  List<Field> get fields {
    return [
      BooleanField(
        name: 'enable',
        initialValue: initialSetting,
      ),
    ];
  }

  @override
  bool valueFromQueryGroup(Map<String, String> group) {
    return valueOf('enable', group)!;
  }

  @override
  Widget buildUseCase(
    BuildContext context,
    Widget child,
    bool setting,
  ) {
    return setting ? builder(context, child) : child;
  }
}
