import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

class AlignMode extends Mode<Alignment> {
  AlignMode(super.value);

  @override
  Widget build(BuildContext context, Widget child) {
    return Align(
      alignment: value,
      child: child,
    );
  }
}

class AlignAddon extends ModeAddon<Alignment> {
  AlignAddon([this.alignment = Alignment.center])
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
      ObjectDropdownField<Alignment>(
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
