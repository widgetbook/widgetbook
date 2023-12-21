import 'package:flutter/widgets.dart';

import '../core/addon.dart';
import '../core/mode.dart';
import '../core/mode_addon.dart';
import '../fields/fields.dart';

class AlignmentMode extends Mode<Alignment> {
  AlignmentMode(super.value);

  @override
  Widget build(BuildContext context, Widget child) {
    return Align(
      alignment: value,
      child: child,
    );
  }
}

/// An [Addon] for wrapping use-cases with [Align] widget.
class AlignmentAddon extends ModeAddon<Alignment> {
  AlignmentAddon([this.alignment = Alignment.center])
      : super(
          name: 'Alignment',
          modeBuilder: AlignmentMode.new,
        );

  final Alignment alignment;

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
      ListField<Alignment>(
        name: 'alignment',
        initialValue: alignment,
        values: alignments.keys.toList(),
        labelBuilder: (value) => alignments[value]!,
      ),
    ];
  }

  @override
  Alignment valueFromQueryGroup(Map<String, String> group) {
    return valueOf('alignment', group)!;
  }
}
