import 'package:flutter/widgets.dart';

import '../core/core.dart';
import '../fields/fields.dart';

class AlignmentMode extends Mode<Alignment> {
  AlignmentMode(Alignment value) : super(value, AlignmentAddon(value));
}

/// An [Addon] for wrapping use-cases with [Align] widget.
class AlignmentAddon extends Addon<Alignment> {
  AlignmentAddon([Alignment alignment = Alignment.center])
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
  List<Field> get fields {
    return [
      ObjectDropdownField<Alignment>(
        name: 'value',
        initialValue: initialValue,
        values: alignments.keys.toList(),
        labelBuilder: (value) => alignments[value]!,
      ),
    ];
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
