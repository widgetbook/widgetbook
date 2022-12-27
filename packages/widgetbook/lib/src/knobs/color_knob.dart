import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/knobs/knobs.dart';

const _kFallbackColor = 0xFFFF0000;

extension on String {
  Color asColor() {
    if (length != 7) {
      return const Color(_kFallbackColor);
    }
    return Color(int.tryParse(replaceFirst('#', '0xFF')) ?? _kFallbackColor);
  }
}

extension on Color {
  String get hexString =>
      '#${value.toRadixString(16).substring(2, 8).toUpperCase()}';
}

class ColorKnob extends Knob<Color> {
  ColorKnob({
    required super.label,
    super.description,
    required super.value,
  });

  @override
  Widget build() => ColorKnobWidget(
        label: label,
        value: value.hexString,
        description: description,
      );
}

class ColorKnobWidget extends StatefulWidget {
  const ColorKnobWidget({
    super.key,
    required this.label,
    required this.description,
    required this.value,
  });

  final String label;
  final String? description;
  final String? value;

  @override
  State<ColorKnobWidget> createState() => _ColorKnobWidgetState();
}

class _ColorKnobWidgetState extends State<ColorKnobWidget> {
  late Color value;
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.value != null) {
      controller.text = widget.value!;
      value = widget.value!.asColor();
    }
  }

  @override
  Widget build(BuildContext context) {
    return KnobWrapper(
      description: widget.description,
      title: widget.label,
      child: TextField(
        key: Key('${widget.label}-colorKnob'),
        controller: controller,
        onChanged: (v) {
          setState(() {
            value = v.asColor();
          });
          context.read<KnobsNotifier>().update(widget.label, v.asColor());
        },
      ),
    );
  }
}
