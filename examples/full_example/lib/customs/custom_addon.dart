/// A custom addon example for Widgetbook
///
/// [Ref link]: https://docs.widgetbook.io/addons/custom-addon
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

class AlignmentAddon extends WidgetbookAddon<Alignment> {
  AlignmentAddon({
    this.initialAlignment = Alignment.center,
  }) : super(
         name: 'Alignment',
       );

  final Alignment initialAlignment;

  @override
  List<Field<Alignment>> get fields {
    return [
      ObjectDropdownField<Alignment>(
        name: 'alignment',
        initialValue: initialAlignment,
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
      ),
    ];
  }

  @override
  Alignment valueFromQueryGroup(Map<String, String> group) {
    return valueOf<Alignment>('alignment', group)!;
  }

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
}
