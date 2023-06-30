/// A custom addon example for Widgetbook
///
/// [Ref link]: https://docs.widgetbook.io/addons/custom-addon
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

class AlignmentAddon extends WidgetbookAddon<Alignment> {
  AlignmentAddon({
    required this.alignment,
    Alignment? initialAlignment,
  }) : super(
          name: 'Alignment',
          initialSetting: initialAlignment ?? alignment,
        );

  final Alignment alignment;

  @override
  Widget buildUseCase(
    BuildContext context,
    Widget child,
    Alignment setting,
  ) {
    // customize how the use case is built using your custom Addon
    return Align(
      alignment: setting,
      child: child,
    );
  }

  @override
  List<Field<Alignment>> get fields {
    return [
      ListField<Alignment>(
        name: 'alignment',
        values: [
          Alignment.topLeft,
          Alignment.topCenter,
          Alignment.topRight,
          Alignment.centerLeft,
          Alignment.center,
          Alignment.centerRight,
          Alignment.bottomLeft,
          Alignment.bottomCenter,
          Alignment.bottomRight,
        ],
        initialValue: initialSetting,
      )
    ];
  }

  @override
  Alignment valueFromQueryGroup(Map<String, String> group) {
    return valueOf<Alignment>('alignment', group) ?? initialSetting;
  }
}
