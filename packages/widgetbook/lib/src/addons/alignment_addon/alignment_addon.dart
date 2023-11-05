import 'package:flutter/material.dart';

import '../../fields/fields.dart';
import '../common/common.dart';

/// A [WidgetbookAddon] for wrapping use-cases with [Align] widget.
class AlignmentAddon extends WidgetbookAddon<Alignment> {
  AlignmentAddon({
    this.initialAlignment = Alignment.center,
  }) : super(
          name: 'Alignment',
        );

  final Alignment initialAlignment;

  static final alignments = {
    Alignment.topLeft: 'Top Left',
    Alignment.topCenter: 'Top Center',
    Alignment.topRight: 'Top Right',
    Alignment.centerLeft: 'Center Left',
    Alignment.center: 'Center',
    Alignment.centerRight: 'Center Right',
    Alignment.bottomLeft: 'Bottom Left',
    Alignment.bottomCenter: 'Bottom Center',
    Alignment.bottomRight: 'Bottom Right',
  };

  @override
  List<Field<Alignment>> get fields {
    return [
      ListField<Alignment>(
        name: 'alignment',
        initialValue: initialAlignment,
        values: alignments.keys.toList(),
        labelBuilder: (value) => alignments[value]!,
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
    return Align(
      alignment: setting,
      child: child,
    );
  }
}
