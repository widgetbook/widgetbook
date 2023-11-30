import 'package:flutter/widgets.dart';

import '../../fields/fields.dart';
import 'base/mode.dart';
import 'base/modes_addon.dart';

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

class AlignmentAddon extends ModesAddon<AlignmentMode> {
  AlignmentAddon([this.alignment = Alignment.center])
      : super(
          name: 'Alignment',
          modes: alignments.entries
              .map((entry) => AlignmentMode(entry.key))
              .toList(),
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
  AlignmentMode valueFromQueryGroup(Map<String, String> group) {
    return AlignmentMode(
      valueOf<Alignment>('alignment', group)!,
    );
  }
}
