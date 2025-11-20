import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

class AlignMode extends Mode<Alignment> {
  AlignMode(Alignment value) : super(value, AlignmentAddon(value));
}

/// An [Addon] for wrapping use-cases with [Align] widget.
class AlignAddon extends Addon<Alignment> with SingleFieldOnly {
  AlignAddon([Alignment alignment = Alignment.center])
    : super(
        name: 'Alignment',
        initialValue: alignment,
      );

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
  Field<Alignment> get field {
    return ObjectDropdownField<Alignment>(
      name: 'alignment',
      initialValue: initialValue,
      values: alignments.keys.toList(),
      labelBuilder: (value) => alignments[value]!,
    );
  }

  @override
  Widget apply(
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
